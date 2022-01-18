Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB14491EB0
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jan 2022 05:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbiAREw3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jan 2022 23:52:29 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42642 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236679AbiAREwY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jan 2022 23:52:24 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 14037212CC;
        Tue, 18 Jan 2022 04:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642481543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sw4hfNGr5x6TscU5Ve4P2U3Ue6tHFD6HnJJdmmDa7uI=;
        b=CUZ7rJao7YLWLjic6AMcW8yJToIJhjeJOa9NRZjbWPeltwNq5Ifv/VnWCnDqwOOb3yRMPd
        BMsGlUlfdd6o1S9bnkbcVJjxKhuIJR0cSikMQO9/pb0/0Yb3TcH5cYspWh+YEJ6vvuCJXN
        p41hQEMvgKXU6GgGoINFJnE/8LPkHfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642481543;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sw4hfNGr5x6TscU5Ve4P2U3Ue6tHFD6HnJJdmmDa7uI=;
        b=LO1RAiXr+E8tPvUCtthwKjetsY7tLvQoSUEqGeYzpxw2lXwS9paB3P4eboeslMoHGjYQ46
        j7z1YmUb11mZWJAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD27413A81;
        Tue, 18 Jan 2022 04:52:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vbRQGoVH5mFVDgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 18 Jan 2022 04:52:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     "Petr Vorel" <pvorel@suse.cz>, linux-nfs@vger.kernel.org,
        "Yong Sun" <yosun@suse.com>
Subject: Re: pynfs: [NFS 4.0] SEC7, LOCK24 test failures
In-reply-to: <YLZS1iMJR59n4hue@pick.fieldses.org>
References: <YLY9pKu38lEWaXxE@pevik>, <YLZS1iMJR59n4hue@pick.fieldses.org>
Date:   Tue, 18 Jan 2022 15:52:18 +1100
Message-id: <164248153844.24166.16775550865302060652@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 02 Jun 2021, J. Bruce Fields wrote:
> On Tue, Jun 01, 2021 at 04:01:08PM +0200, Petr Vorel wrote:
>=20
> > LOCK24   st_lock.testOpenUpgradeLock                              : FAILU=
RE
> >            OP_LOCK should return NFS4_OK, instead got
> >            NFS4ERR_BAD_SEQID
>=20
> I suspect the server's actually OK here, but I need to look more
> closely.
>=20
I agree.
I think this patch fixes the test.

NeilBrown

From: NeilBrown <neilb@suse.de>
Date: Tue, 18 Jan 2022 15:50:37 +1100
Subject: [PATCH] Fix NFSv4.0 LOCK24 test

Only the first lock request for a given open-owner can use lock_file.
Subsequent lock request must use relock_file.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 nfs4.0/servertests/st_lock.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/nfs4.0/servertests/st_lock.py b/nfs4.0/servertests/st_lock.py
index 468672403ffe..db08fbeedac4 100644
--- a/nfs4.0/servertests/st_lock.py
+++ b/nfs4.0/servertests/st_lock.py
@@ -886,6 +886,7 @@ class open_sequence:
         self.client =3D client
         self.owner =3D owner
         self.lockowner =3D lockowner
+        self.lockseq =3D 0
     def open(self, access):
         self.fh, self.stateid =3D self.client.create_confirm(self.owner,
 						access=3Daccess,
@@ -899,15 +900,21 @@ class open_sequence:
     def close(self):
         self.client.close_file(self.owner, self.fh, self.stateid)
     def lock(self, type):
-        res =3D self.client.lock_file(self.owner, self.fh, self.stateid,
-                    type=3Dtype, lockowner=3Dself.lockowner)
+        if self.lockseq =3D=3D 0:
+            res =3D self.client.lock_file(self.owner, self.fh, self.stateid,
+                                        type=3Dtype, lockowner=3Dself.lockow=
ner)
+        else:
+            res =3D self.client.relock_file(self.lockseq, self.fh, self.lock=
stateid,
+                                        type=3Dtype)
         check(res)
         if res.status =3D=3D NFS4_OK:
             self.lockstateid =3D res.lockid
+            self.lockseq =3D self.lockseq + 1
     def unlock(self):
         res =3D self.client.unlock_file(1, self.fh, self.lockstateid)
         if res.status =3D=3D NFS4_OK:
             self.lockstateid =3D res.lockid
+            self.lockseq =3D self.lockseq + 1
=20
 def testOpenUpgradeLock(t, env):
     """Try open, lock, open, downgrade, close
--=20
2.34.1

