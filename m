Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE99E7DA160
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 21:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjJ0TgH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 15:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJ0TgG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 15:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFB21A1
        for <linux-nfs@vger.kernel.org>; Fri, 27 Oct 2023 12:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698435318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LKsc88pkZHoqAPKfroQrH7c1N9Kl+C8Sx8ZuUjs9qsY=;
        b=MoWRW1idNtc7CaZmSYM713wmheH16WZpxDRnA7TVBPEDqAB2iEhiXeucUSyxN6y09sW145
        CDnKrCKfJNP8y9eLH+NtMFBd7mPWBHmMX9ZlCznnxrWzv6VP6owIzGnrbG35rzI4rfGfgC
        3WjS1MuJE3cE1PPVuVAXWNY+si1Z96Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-kITnugaPMLiuURBJCApRtw-1; Fri,
 27 Oct 2023 15:35:04 -0400
X-MC-Unique: kITnugaPMLiuURBJCApRtw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FBE42810D6C;
        Fri, 27 Oct 2023 19:35:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id C18C7502E;
        Fri, 27 Oct 2023 19:35:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 27 Oct 2023 21:34:03 +0200 (CEST)
Date:   Fri, 27 Oct 2023 21:34:00 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Ingo Molnar <mingo@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd_copy_write_verifier: use read_seqbegin() rather
 than read_seqbegin_or_lock()
Message-ID: <20231027193359.GB24128@redhat.com>
References: <20231025163006.GA8279@redhat.com>
 <20231026145018.GA19598@redhat.com>
 <ZTvc0Z6DJEYXI/TL@tissot.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTvc0Z6DJEYXI/TL@tissot.1015granger.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/27, Chuck Lever wrote:
>
> On Thu, Oct 26, 2023 at 04:50:18PM +0200, Oleg Nesterov wrote:
> > The usage of read_seqbegin_or_lock() in nfsd_copy_write_verifier()
> > is wrong. "seq" is always even and thus "or_lock" has no effect,
> > this code can never take ->writeverf_lock for writing.
> >
> > I guess this is fine, nfsd_copy_write_verifier() just copies 8 bytes
> > and nfsd_reset_write_verifier() is supposed to be very rare operation
> > so we do not need the adaptive locking in this case.
> >
> > Yet the code looks wrong and sub-optimal, it can use read_seqbegin()
> > without changing the behaviour.
>
> I was debating whether to add Fixes/Cc-stable, but if the behavior
> doesn't change, this doesn't need a backport.

Yes, yes, sorry for confusion. This code is not buggy. Just a) it looks
confusing because read_seqbegin_or_lock() doesn't do what it is supposed
to do, and b) I am going to change the semantics of done_seqretry() to
enforce the locking on the 2nd pass.

Chuck, I can reword the changelog to make it more clear and send V2 if
you think this makes sense.

Thanks,

Oleg.

