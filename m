Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20214F2257
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Apr 2022 07:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiDEFDT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Apr 2022 01:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiDEFCs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Apr 2022 01:02:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CD111A22
        for <linux-nfs@vger.kernel.org>; Mon,  4 Apr 2022 22:00:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 63DD4210FC;
        Tue,  5 Apr 2022 05:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649134810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gfIatCEuRT9nJiPCaMct2VuLLtbJFsIG/prQVRn4mg4=;
        b=NoKDWVE567DDY/YhZuw9nCbcp+eQtcMckeBPUBg35cl1IQuxiv+IlKKMEY/2YAEJa5yARF
        b+t5XAlTUn0myi9fYugtNmmt941BzYtupJ7cv9qe+M1jKsesWt5z9Kc6IX416C9Iyxr6FH
        7nXsKceXA6wYg9Nv1XT/1SwL8nFRgi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649134810;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gfIatCEuRT9nJiPCaMct2VuLLtbJFsIG/prQVRn4mg4=;
        b=pcpVnecBQjedAaeizVAg5KTD975J0/q3XKIgHER1jZZfxeyc++sUmLvmZsNDAQWsZdnZbn
        rytK6SM6aZZ1VcCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5324713B95;
        Tue,  5 Apr 2022 05:00:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8PywBNnMS2IAOgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 05 Apr 2022 05:00:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Question about RDMA server...
In-reply-to: <50ea0e392fd8b0b1bec987e5c5f923c7baef439f.camel@hammerspace.com>
References: <82662b7190f26fb304eb0ab1bb04279072439d4e.camel@hammerspace.com>,
 <1114899D-BBF5-4CB1-9126-E4E652ACAAB6@oracle.com>,
 <5DCBD9EB-7721-48FC-9EBD-58B7DF05A704@oracle.com>,
 <8af942181abb39cd7ce8fe91be9c4c2f8c9f2c56.camel@hammerspace.com>,
 <2E4807E4-5086-4F15-B790-8D952B394FE5@oracle.com>,
 <974fa169124661c2ce5ed549d499837435cc7b4c.camel@hammerspace.com>,
 <E7FD566B-0570-4D14-9936-5C737B619E0B@oracle.com>,
 <b9b98ad9b21f228566a5ebd643198c669c9f3408.camel@hammerspace.com>,
 <930A468B-E674-4F5D-8BC0-DB9F45611A9D@oracle.com>,
 <50ea0e392fd8b0b1bec987e5c5f923c7baef439f.camel@hammerspace.com>
Date:   Tue, 05 Apr 2022 15:00:06 +1000
Message-id: <164913480601.10985.1519370018759325971@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 05 Apr 2022, Trond Myklebust wrote:
> On Mon, 2022-04-04 at 15:34 +0000, Chuck Lever III wrote:
> >=20
....
> >=20
> > I gotta ask: Why does cache_defer_req() check if thread_wait is zero?
> > Is there some code in the kernel now that sets it to zero? I see only
> > these two values:
> >=20
> > =C2=A0784=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!test_bit(S=
P_CONGESTED, &pool->sp_flags))
> > =C2=A0785=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rqstp->rq_chandle.thread_wait =3D 5*HZ;
> > =C2=A0786=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > =C2=A0787=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rqstp->rq_chandle.thread_wait =3D 1*HZ;
>=20
>=20
> That test goes all the way back to commit f16b6e8d838b ("sunrpc/cache:
> allow threads to block while waiting for cache update."), so probably
> more of a question for Neil.

12 years ago....  the commit message suggests that the "underlying
transport" might not approve of sleeping, but I cannot think what that
might mean.  Probably it seemed to mean something earlier in the design
process but I discarded the idea without discarding the code.

> I don't see any immediate problems with removing it: even if someone
> does set a value of 0, the wait code itself should cope.
>=20
Agreed.

NeilBrown
