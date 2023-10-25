Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507247D7306
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Oct 2023 20:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbjJYSMr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Oct 2023 14:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjJYSMp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Oct 2023 14:12:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E94193
        for <linux-nfs@vger.kernel.org>; Wed, 25 Oct 2023 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698257515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5cnB0Wl3nHUb0LUJdrBGafq84dM6Foil+zCdtAV+P7k=;
        b=c5K6Fihg5OsDYlGFEGtOO5qMg4hNlKeGE/8LmVB/bIJOQ7wf/xCOEp/YvKTYu87wqvtb4I
        sc/0J10AVAdDFhNLd+3tZBQCRiBmOicTuay3KyZMcnedm2QzWa6Z7HBwQuCIYgAmTNcwGx
        ibHULv4vnu0C52FCU5qy8hWExpjrBsY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-CQnMMDF4N_6cy-Ffx1SVSw-1; Wed, 25 Oct 2023 14:11:53 -0400
X-MC-Unique: CQnMMDF4N_6cy-Ffx1SVSw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 238A988D01C;
        Wed, 25 Oct 2023 18:11:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.21])
        by smtp.corp.redhat.com (Postfix) with SMTP id DA36C492BFA;
        Wed, 25 Oct 2023 18:11:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 25 Oct 2023 20:10:52 +0200 (CEST)
Date:   Wed, 25 Oct 2023 20:10:49 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Ingo Molnar <mingo@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: nfsd_copy_write_verifier: wrong usage of read_seqbegin_or_lock()
Message-ID: <20231025181049.GD29779@redhat.com>
References: <20231025163006.GA8279@redhat.com>
 <ZTlJmuDpGE+U3pEF@tissot.1015granger.net>
 <20231025173931.GA29779@redhat.com>
 <ZTlXD/hQAVQMKfaE@tissot.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTlXD/hQAVQMKfaE@tissot.1015granger.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/25, Chuck Lever wrote:
>
> On Wed, Oct 25, 2023 at 07:39:31PM +0200, Oleg Nesterov wrote:
> > Hi Chuck,
> >
> > Thanks for your reply. But I am already sleeping and I can't understand it.
>
> I was responding to "I can not understand the intent." But also I
> was hoping that explanation would help you provide a correct
> replacement for the existing code.

In case I was not clear, I have already provided the replacement for the
existing code which looks "correct" for me ;) Nevermind, please forget.

> > 1. Do you agree that the current nfsd_copy_write_verifier() code makes no sense?
>
> Probably.
>
>
> >    I mean, the usage of read_seqbegin_or_lock() suggests that if the lockless
> >    pass fails it should take writeverf_lock for writing. But this can't happen,
> >    and thus this code doesn't look right no matter what. None of the
> >    read_seqbegin_or_lock/need_seqretry/done_seqretry helpers make any sense
> >    because "seq" is alway even.
>
> > 2. If yes, which change do you prefer? I'd prefer the patch at the end.
>
> Based on my limited understanding of read_seqbegin(), the patch at
> the end seems cleanest and is on-point. Please post an official
> version of that to linux-nfs@ with a full patch description, and
> I'll see that it gets into v6.8-rc with proper tags, review, and
> testing.

Ok, will do tomorrow.

Thanks,

Oleg.

