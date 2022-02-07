Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECD84AB491
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 07:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347270AbiBGGP4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 01:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241374AbiBGEQi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Feb 2022 23:16:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A536C061A73
        for <linux-nfs@vger.kernel.org>; Sun,  6 Feb 2022 20:16:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AB223210E5;
        Mon,  7 Feb 2022 04:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644207395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d5p0MIHswhcS0+g7iLFtPUAf+O5Ri22V68bNXUlBffw=;
        b=Wc5rIzjckDqmiyJdtf+x9Y4UktzST04PjVy7GYZMc9HK8kIF5RjXg5fb9jFLJNtSxcN6hD
        k5Oh5Gm1Ox/qwmklF79SCX8JuB0JGwmVIl7RO1y/WBke6SPIovYX0PlPtV4TXGP/SiL0iX
        tthHs9S1K5BvAuEUddM86He54WyPpIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644207395;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d5p0MIHswhcS0+g7iLFtPUAf+O5Ri22V68bNXUlBffw=;
        b=TsJcAIcjXlsHaMUxo4Gj3osnxJJo1A7Bwppdzzr7C5zogE/Xu0GDhZ1r1MB+TpkULQtF03
        g33tjNItLrIcawDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 051A41330E;
        Mon,  7 Feb 2022 04:16:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZvVxLCGdAGK3LQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 07 Feb 2022 04:16:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>
Cc:     "'Trond Myklebust'" <trondmy@hammerspace.com>,
        "'bfields@fieldses.org'" <bfields@fieldses.org>,
        "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>,
        "'mbenjami@redhat.com'" <mbenjami@redhat.com>
Subject: RE: client caching and locks
In-reply-to: =?utf-8?q?=3COSZPR01MB7050AD4E6F85ABE698EC4CA3EF289=40OSZPR01MB?=
 =?utf-8?q?7050=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom=3E?=
References: <20201001214749.GK1496@fieldses.org>,
 <CAKOnarndL1-u5jGG2VAENz2bEc9wsERH6rGTbZeYZy+WyAUk-w@mail.gmail.com>,
 <20201006172607.GA32640@fieldses.org>,
 <164066831190.25899.16641224253864656420@noble.neil.brown.name>,
 <20220103162041.GC21514@fieldses.org>, =?utf-8?q?=3COSZPR01MB7050F9737016E8?=
 =?utf-8?q?E3F0FD5255EF4A9=40OSZPR01MB7050=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom?=
 =?utf-8?q?=3E=2C?=
 <03e4cc01e9e66e523474c10846ee22147b78addf.camel@hammerspace.com>,
 <20220104153205.GA7815@fieldses.org>,
 <1257915fc5fd768e6c1c70fd3e8e3ed3fa1dc33e.camel@hammerspace.com>, 
 =?utf-8?q?=3COSZPR01MB7050C5098D47514FFEC2DA82EF4B9=40OSZPR01MB7050=2Ejpnpr?=
 =?utf-8?q?d01=2Eprod=2Eoutlook=2Ecom=3E=2C?=
 <20220105220353.GF25384@fieldses.org>,
 <164176553564.25899.8328729314072677083@noble.neil.brown.name>, =?utf-8?q??=
 =?utf-8?q?=3COSZPR01MB7050A3B0D15D38420532CD31EF579=40OSZPR01MB7050=2Ejpnpr?=
 =?utf-8?q?d01=2Eprod=2Eoutlook=2Ecom=3E=2C?=
 <164245842205.24166.5326728089527364990@noble.neil.brown.name>, =?utf-8?q??=
 =?utf-8?q?=3COSZPR01MB7050DF6073AB2EC4F82A589AEF279=40OSZPR01MB7050=2Ejpnpr?=
 =?utf-8?q?d01=2Eprod=2Eoutlook=2Ecom=3E=2C?=
 <164377705404.1660.1273338182990772730@noble.neil.brown.name>, =?utf-8?q??=
 =?utf-8?q?=3COSZPR01MB7050AD4E6F85ABE698EC4CA3EF289=40OSZPR01MB7050=2Ejpnpr?=
 =?utf-8?q?d01=2Eprod=2Eoutlook=2Ecom=3E?=
Date:   Mon, 07 Feb 2022 15:16:19 +1100
Message-id: <164420737943.1660.1723177400171021481@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 03 Feb 2022, inoguchi.yuki@fujitsu.com wrote:
> Thank you for the review.
>=20
> > I would make 2 changes.
> >  1/ invalidate when opening a file, rather than when closing.
> >    This fits better with the understanding of close-to-open consistency
> >    that we flush writes when closing and verify the cache when opening
> >  2/ I would be more careful about determining exactly when the
> >    invalidation might be needed.
>=20
> Yes, I'm willing to make these changes.
>=20
> > In nfs_post_op_updatE_inode() there is the code:
> >=20
> >     if ((fattr->valid & NFS_ATTR_FATTR_CHANGE) !=3D 0 &&
> >             (fattr->valid & NFS_ATTR_FATTR_PRECHANGE) =3D=3D 0) {
> >         fattr->pre_change_attr =3D inode_peek_iversion_raw(inode);
> >         fattr->valid |=3D NFS_ATTR_FATTR_PRECHANGE;
> >     }
>=20
> You mean nfs_post_op_update_inode_force_wcc_locked(), not nfs_post_op_updat=
e_inode(), right?
> This is just make sure --- so I can set the new flag in appropriate place :)

Yes, you are correct.

>=20
> > I assume that code doesn't end up running when you write to a file for
> > which you have a delegation, but I'm not at all certain - we would have
> > to check.
>=20
> Maybe it is nfs_check_inode_attributes()?=20
> It returns without doing anything if you have a delegation.=20
> It is called from:=20
>  nfs_post_op_update_inode_force_wcc_locked()
>  -> nfs_post_op_update_inode_locked()
>     -> nfs_refresh_inode_locked()
>        -> nfs_check_inode_attributes()
>=20
> 1476 static int nfs_check_inode_attributes(struct inode *inode, struct nfs_=
fattr *fattr)
> 1477 {
> 1478         struct nfs_inode *nfsi =3D NFS_I(inode);
> 1479         loff_t cur_size, new_isize;
> 1480         unsigned long invalid =3D 0;
> 1481         struct timespec64 ts;
> 1482=20
> 1483         if (NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
> 1484                 return 0;
>=20

I don't *think* that is relevant.  If you set the new flag where I
suggested, that code will already have run before it gets to the
have_delegation test.

nfs4_write_need_cache_consistency_data() seems relevant.
If that returns false (which it does when there is a delegation) the
WRITE request doesn't even ask for attributes.
In that case if nfs_post_op_update_inode_force_wcc_locked() is called,
it will find that NFS_ATTR_FATTR_CHANGE is not set, so it won't try to
set ->pre_change_attr with a "fake" value, and so won't set the new flag.

NeilBrown
