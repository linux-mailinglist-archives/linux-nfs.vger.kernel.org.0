Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8813428BF
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Mar 2021 23:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhCSWiL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Mar 2021 18:38:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:45106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230226AbhCSWiL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 19 Mar 2021 18:38:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C0FEFAC23;
        Fri, 19 Mar 2021 22:38:09 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Sat, 20 Mar 2021 09:38:04 +1100
Cc:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH v2] nfsd: report client confirmation status in "info" file
In-Reply-To: <87v99neruh.fsf@notabene.neil.brown.name>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
 <874khui7hr.fsf@notabene.neil.brown.name>
 <20210302032733.GC16303@fieldses.org>
 <87y2ejerwn.fsf@notabene.neil.brown.name>
 <87v99neruh.fsf@notabene.neil.brown.name>
Message-ID: <87h7l6epmb.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


mountd can now monitor clients appearing and disappearing in
/proc/fs/nfsd/clients, and will log these events, in liu of the logging
of mount/unmount events for NFSv3.

Currently it cannot distinguish between unconfirmed clients (which might
be transient and totally uninteresting) and confirmed clients.

So add a "status: " line which reports either "confirmed" or
"unconfirmed", and use fsnotify to report that the info file
has been modified.

This requires a bit of infrastructure to keep the dentry for the "info"
file.  There is no need to take a counted reference as the dentry must
remain around until the client is removed.

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 fs/nfsd/nfs4state.c | 19 +++++++++++++++----
 fs/nfsd/nfsctl.c    | 14 ++++++++------
 fs/nfsd/nfsd.h      |  4 +++-
 fs/nfsd/state.h     |  4 ++++
 4 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 97447a64bad0..ec1b2dd8fd45 100644
=2D-- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -43,6 +43,7 @@
 #include <linux/sunrpc/addr.h>
 #include <linux/jhash.h>
 #include <linux/string_helpers.h>
+#include <linux/fsnotify.h>
 #include "xdr4.h"
 #include "xdr4cb.h"
 #include "vfs.h"
@@ -2352,6 +2353,10 @@ static int client_info_show(struct seq_file *m, void=
 *v)
 	memcpy(&clid, &clp->cl_clientid, sizeof(clid));
 	seq_printf(m, "clientid: 0x%llx\n", clid);
 	seq_printf(m, "address: \"%pISpc\"\n", (struct sockaddr *)&clp->cl_addr);
+	if (test_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags))
+		seq_puts(m, "status: confirmed\n");
+	else
+		seq_puts(m, "status: unconfirmed\n");
 	seq_printf(m, "name: ");
 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
@@ -2702,6 +2707,7 @@ static struct nfs4_client *create_client(struct xdr_n=
etobj name,
 	int ret;
 	struct net *net =3D SVC_NET(rqstp);
 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
+	struct dentry *dentries[ARRAY_SIZE(client_files)];
=20
 	clp =3D alloc_client(name);
 	if (clp =3D=3D NULL)
@@ -2721,9 +2727,11 @@ static struct nfs4_client *create_client(struct xdr_=
netobj name,
 	memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
 	clp->cl_cb_session =3D NULL;
 	clp->net =3D net;
=2D	clp->cl_nfsd_dentry =3D nfsd_client_mkdir(nn, &clp->cl_nfsdfs,
=2D			clp->cl_clientid.cl_id - nn->clientid_base,
=2D			client_files);
+	clp->cl_nfsd_dentry =3D nfsd_client_mkdir(
+		nn, &clp->cl_nfsdfs,
+		clp->cl_clientid.cl_id - nn->clientid_base,
+		client_files, dentries);
+	clp->cl_nfsd_info_dentry =3D dentries[0];
 	if (!clp->cl_nfsd_dentry) {
 		free_client(clp);
 		return NULL;
@@ -2798,7 +2806,10 @@ move_to_confirmed(struct nfs4_client *clp)
 	list_move(&clp->cl_idhash, &nn->conf_id_hashtbl[idhashval]);
 	rb_erase(&clp->cl_namenode, &nn->unconf_name_tree);
 	add_clp_to_name_tree(clp, &nn->conf_name_tree);
=2D	set_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags);
+	if (!test_and_set_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags) &&
+	    clp->cl_nfsd_dentry &&
+	    clp->cl_nfsd_info_dentry)
+		fsnotify_dentry(clp->cl_nfsd_info_dentry, FS_MODIFY);
 	renew_client_locked(clp);
 }
=20
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index ef86ed23af82..94ce1eabd9d1 100644
=2D-- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1266,7 +1266,8 @@ static void nfsdfs_remove_files(struct dentry *root)
 /* XXX: cut'n'paste from simple_fill_super; figure out if we could share
  * code instead. */
 static  int nfsdfs_create_files(struct dentry *root,
=2D					const struct tree_descr *files)
+				const struct tree_descr *files,
+				struct dentry **fdentries)
 {
 	struct inode *dir =3D d_inode(root);
 	struct inode *inode;
@@ -1275,8 +1276,6 @@ static  int nfsdfs_create_files(struct dentry *root,
=20
 	inode_lock(dir);
 	for (i =3D 0; files->name && files->name[0]; i++, files++) {
=2D		if (!files->name)
=2D			continue;
 		dentry =3D d_alloc_name(root, files->name);
 		if (!dentry)
 			goto out;
@@ -1290,6 +1289,8 @@ static  int nfsdfs_create_files(struct dentry *root,
 		inode->i_private =3D __get_nfsdfs_client(dir);
 		d_add(dentry, inode);
 		fsnotify_create(dir, dentry);
+		if (fdentries)
+			fdentries[i] =3D dentry;
 	}
 	inode_unlock(dir);
 	return 0;
@@ -1301,8 +1302,9 @@ static  int nfsdfs_create_files(struct dentry *root,
=20
 /* on success, returns positive number unique to that client. */
 struct dentry *nfsd_client_mkdir(struct nfsd_net *nn,
=2D		struct nfsdfs_client *ncl, u32 id,
=2D		const struct tree_descr *files)
+				 struct nfsdfs_client *ncl, u32 id,
+				 const struct tree_descr *files,
+				 struct dentry **fdentries)
 {
 	struct dentry *dentry;
 	char name[11];
@@ -1313,7 +1315,7 @@ struct dentry *nfsd_client_mkdir(struct nfsd_net *nn,
 	dentry =3D nfsd_mkdir(nn->nfsd_client_dir, ncl, name);
 	if (IS_ERR(dentry)) /* XXX: tossing errors? */
 		return NULL;
=2D	ret =3D nfsdfs_create_files(dentry, files);
+	ret =3D nfsdfs_create_files(dentry, files, fdentries);
 	if (ret) {
 		nfsd_client_rmdir(dentry);
 		return NULL;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 8bdc37aa2c2e..9aee72f65330 100644
=2D-- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -107,7 +107,9 @@ struct nfsdfs_client {
=20
 struct nfsdfs_client *get_nfsdfs_client(struct inode *);
 struct dentry *nfsd_client_mkdir(struct nfsd_net *nn,
=2D		struct nfsdfs_client *ncl, u32 id, const struct tree_descr *);
+				 struct nfsdfs_client *ncl, u32 id,
+				 const struct tree_descr *,
+				 struct dentry **fdentries);
 void nfsd_client_rmdir(struct dentry *dentry);
=20
=20
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 73deea353169..54cab651ac1d 100644
=2D-- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -371,6 +371,10 @@ struct nfs4_client {
=20
 	/* debugging info directory under nfsd/clients/ : */
 	struct dentry		*cl_nfsd_dentry;
+	/* 'info' file within that directory. Ref is not counted,
+	 * but will remain valid iff cl_nfsd_dentry !=3D NULL
+	 */
+	struct dentry		*cl_nfsd_info_dentry;
=20
 	/* for nfs41 callbacks */
 	/* We currently support a single back channel with a single slot */
=2D-=20
2.30.1


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmBVJ80OHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbmEaQ/5AQvLAvVqkmCYrWa4+Gvv/vB2+o52R7uJjA3q
o9oFgO2nHGcQAUS9F0mwRnVFjhbX8J3WiDuUjYj3nIz1IpPNKuzQ7Uqbl87r6swM
CstGpH0I6eZwb59ptUhtIRm1SY+XzRuN8BuYUj0cHombnXRLW3GPvWuLGEyOIscA
ZxxMujAe21CQZUSRftd50scuaL3dM53BEqHgJAXJLx+85ZyZat5qWEoc92YqPq5t
W80j6t87Lc0Gp0obF/Cdif0R/4bH+aRDhP0YLwC3bZH8J6mthrYb9aVjq11Wausw
pBIoauRwvk6edB0qp4qrHKxPTOhNaivLwbHpP34Sn4Ta8751v3lnjOBvTUOlqDoT
9908MSC3yBgQWnPQZTMLNLZdl8d2LyyGv4VzjGFPAfXWvs0qUkBinTGr97HJj+FZ
p5EFUiJAUSiIbPm5nSYZMcKUjDrcAi23KwpdGfJlL/kQY8WWpT5hvqqq7hJ8oTCF
kqPqCGP1Q5EwWup+WNHezb67Iaw64itXs0DcDzKTcMeCYUTO0RY2AYIzyCQuY2N5
LHQkqXHljalNEOkRPr6usJv+9nuX+Z3cIKRdT/ewrwhbVh216vfXcf0lipBjGOTJ
aVshDaEjpUWxk4RLjmvVjArWwndjPwEZ+DR03VZJ0ezALOSWL7xDjL55rgC6dwDf
koEHDkc=
=vxIP
-----END PGP SIGNATURE-----
--=-=-=--
