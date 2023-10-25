Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CC37D7323
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 20:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjJYSVU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 14:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjJYSVU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 14:21:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F8893
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 11:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698258034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+4epdbInVInCVeYKIXIyUBLmKyLSTMUZvsMe0ubchwY=;
        b=QeW+L9Zc9Z+3Lrmt6Vj8HTiSkZ7jwQ1y3Z0sw/aT9pTUSgZqwffkLvmrnCgocPMV77LqR3
        ygG/UIxTeva+QyJ9rVkpdly/LOGx6rZ5d8fUECQtc6gGIW/yMnf+euejuLwS24ERLUOztg
        alCLZ6p/lJveAL6ok7tVhpi8sO/j3dA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-LU1KsTCdOrqkMXxn0lz60Q-1; Wed, 25 Oct 2023 14:20:18 -0400
X-MC-Unique: LU1KsTCdOrqkMXxn0lz60Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13F54185A785;
        Wed, 25 Oct 2023 18:20:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.21])
        by smtp.corp.redhat.com (Postfix) with SMTP id C6C5E492BE9;
        Wed, 25 Oct 2023 18:20:15 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 25 Oct 2023 20:19:17 +0200 (CEST)
Date:   Wed, 25 Oct 2023 20:19:14 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Ingo Molnar <mingo@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: nfsd_copy_write_verifier: wrong usage of read_seqbegin_or_lock()
Message-ID: <20231025181913.GE29779@redhat.com>
References: <20231025163006.GA8279@redhat.com>
 <ZTlJmuDpGE+U3pEF@tissot.1015granger.net>
 <20231025175435.GC29779@redhat.com>
 <ZTlZan240vG8HG/B@tissot.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTlZan240vG8HG/B@tissot.1015granger.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/25, Chuck Lever wrote:
>
> On Wed, Oct 25, 2023 at 07:54:36PM +0200, Oleg Nesterov wrote:
> > On 10/25, Chuck Lever wrote:
> > >
> > > > Another question is why we can't simply turn nn->writeverf into seqcount_t.
> > > > I guess we can't because nfsd_reset_write_verifier() needs spin_lock() to
> > > > serialise with itself, right?
> > >
> > > "reset" is supposed to be very rare operation. Using a lock in that
> > > case is probably quite acceptable, as long as reading the verifier
> > > is wait-free and guaranteed to be untorn.
> > >
> > > But a seqcount_t is only 32 bits.
> >
> > Again, I don't understand you.
> >
> > Once again, we can turn writeverf into seqcount_t, see the patch below.
>
> The patch below does not turn "writeverf" into a seqcount_t, it
> turns "writeverf_lock" into a seqcount_t.

Yes, typo. Of course I meant writeverf_lock. A bit strange it was not clear.

> Your original proposal made no sense.

Which one??? I thought that you agree that the current nfsd_copy_write_verifier()
code makes no send, at least that is how I interpreted your previous email. Confused.

> But I see now what you
> would like to change.

OK,

> I'm not familiar enough with these primitives to have a strong
> opinion. What do you think would be the benefit?

See above. And just in case let me repeat. No, I don't think we can/should turn
writeverf_lock (double check I didn't say "writeverf") into seqcount_t.

Oleg.

