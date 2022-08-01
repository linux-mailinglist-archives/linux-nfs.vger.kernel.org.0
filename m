Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B881586204
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Aug 2022 02:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiHAANh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 31 Jul 2022 20:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiHAANh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 31 Jul 2022 20:13:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C49F588
        for <linux-nfs@vger.kernel.org>; Sun, 31 Jul 2022 17:13:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3FCF52012A;
        Mon,  1 Aug 2022 00:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659312814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1GlIp3gflZVQ96n5C8oHpIElLh9F73lmd+el3tuSZnY=;
        b=0jx8LaKWoUfJw8z5vxbJ3AB97gbuvnbjruhm5bRdp5m4niUyb0Izm48lmk3f/W2bdzkZLp
        fpsePHlZk1noQcr+skvX5QuqaAwc661FXExwTcS1UKSrA7eVgFiWKEEU/VMPXF37Gclcwm
        qFwWyFBqLs433x4nfuejUnfouANvj9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659312814;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1GlIp3gflZVQ96n5C8oHpIElLh9F73lmd+el3tuSZnY=;
        b=MHDI4oeZOOzWLUnehZ1zHtSgpfmJUzMYQRkHIlO1WiBan27zTv5/ONnW5QNGTX95eR1pwp
        Vh4heOyyZQ2s2GDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DDCA13754;
        Mon,  1 Aug 2022 00:13:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2qNjMqwa52LZEgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 01 Aug 2022 00:13:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 06/13] NFSD: add posix ACLs to struct nfsd_attrs
In-reply-to: <2CE51ADF-AC32-48EF-9D9B-107BC8EC0370@oracle.com>
References: <165881740958.21666.5904057696047278505.stgit@noble.brown>,
 <165881793057.21666.7472233362797480106.stgit@noble.brown>,
 <2CE51ADF-AC32-48EF-9D9B-107BC8EC0370@oracle.com>
Date:   Mon, 01 Aug 2022 10:13:29 +1000
Message-id: <165931280988.4359.13998492410477063943@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, 30 Jul 2022, Chuck Lever III wrote:
> > @@ -837,10 +821,8 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
> >=20
> > 	if (attrs.label_failed)
> > 		create->cr_bmval[2] &=3D ~FATTR4_WORD2_SECURITY_LABEL;
> > -
> > -	if (create->cr_acl !=3D NULL)
> > -		do_set_nfs4_acl(rqstp, &resfh, create->cr_acl,
> > -				create->cr_bmval);
> > +	if (attrs.label_failed)
> > +		create->cr_bmval[0] &=3D ~FATTR4_WORD0_ACL;
>=20
> I think this needs to be "if (attrs.acl_failed)". I've fixed this
> in my tree.

Yes, of course :-(.
Thanks,
NeilBrown
