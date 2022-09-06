Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375F95AF844
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Sep 2022 01:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiIFXLV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Sep 2022 19:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIFXLV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Sep 2022 19:11:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A4E876B3
        for <linux-nfs@vger.kernel.org>; Tue,  6 Sep 2022 16:11:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BF6141FAA0;
        Tue,  6 Sep 2022 23:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662505877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RWiKSWrP/QBuwoI8Qp8Wyi4BgKzVeiushOdS3vpLFKI=;
        b=sUpEY7HvReQKGOTZtJjslRzkd/pFIld+v+DiFoBP6Kj/kVMJstw1WFSoMy4BrJXXup8208
        6sUsGYTkGoqIHjYOresNmXQqiSpY7FWXzpAGks3GQtwFRz+KujzYidUpw2pehTlguvXndg
        ofnLmzQ4LJ2JFSYzbsUIkezcqaqmKSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662505877;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RWiKSWrP/QBuwoI8Qp8Wyi4BgKzVeiushOdS3vpLFKI=;
        b=Um6GqWBjb6oT8gJW1Dae0Idniug5KIeNecE381s0UTozk/NYjJ1bQY/Vhpr0yG1hC9h79D
        JulPVwbpVI78o3CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B158313A19;
        Tue,  6 Sep 2022 23:11:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JoH2G5TTF2OQTAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 06 Sep 2022 23:11:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: nfs/001 failing
In-reply-to: <20220906122714.GA25323@fieldses.org>
References: <BF47B6B7-CB52-4E14-94B0-E28FD5C52234@oracle.com>,
 <20220906122714.GA25323@fieldses.org>
Date:   Wed, 07 Sep 2022 09:11:08 +1000
Message-id: <166250586898.30452.12563131953046174303@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 06 Sep 2022, J. Bruce Fields wrote:
> On Mon, Sep 05, 2022 at 04:29:16PM +0000, Chuck Lever III wrote:
> > Bruce reminded me I'm not the only one seeing this failure
> > these days:
> >=20
> > > nfs/001 4s ... - output mismatch (see /root/xfstests-dev/results//nfs/0=
01.out.bad)
> > >    --- tests/nfs/001.out	2019-12-20 17:34:10.569343364 -0500
> > >    +++ /root/xfstests-dev/results//nfs/001.out.bad	2022-09-04 20:01:35.=
502462323 -0400
> > >    @@ -1,2 +1,2 @@
> > >     QA output created by 001
> > >    -203
> > >    +3
> > >    ...
> >=20
> > I'm looking at about 5 other priority bugs at the moment. Can
> > someone else do a little triage?
>=20
> For what it's worth, a bisect lands on
> c0cbe70742f4a70893cd6e5f6b10b6e89b6db95b "NFSD: add posix ACLs to struct
> nfsd_attrs".
>=20
> Haven't really looked at nfs/001 except to note it does have something
> to do with ACLs, so that checks out....

I see the problem.
acl setting was moved to nfsd_setattr().
But nfsd_setattr() contains the lines

	if (!iap->ia_valid)
		return 0;

In the setacl case, ia_valid is 0.

Maybe something like:

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 528afc3be7af..0582a5b16237 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -395,9 +395,6 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (S_ISLNK(inode->i_mode))
 		iap->ia_valid &=3D ~ATTR_MODE;
=20
-	if (!iap->ia_valid)
-		return 0;
-
 	nfsd_sanitize_attrs(inode, iap);
=20
 	if (check_guard && guardtime !=3D inode->i_ctime.tv_sec)
@@ -448,8 +445,10 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			goto out_unlock;
 	}
=20
-	iap->ia_valid |=3D ATTR_CTIME;
-	host_err =3D notify_change(&init_user_ns, dentry, iap, NULL);
+	if (iap->ia_valid) {
+		iap->ia_valid |=3D ATTR_CTIME;
+		host_err =3D notify_change(&init_user_ns, dentry, iap, NULL);
+	}
=20
 out_unlock:
 	if (attr->na_seclabel && attr->na_seclabel->len)


Does that seem reasonable?

Thanks,
NeilBrown
