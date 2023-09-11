Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001F279C158
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjILAyg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 20:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjILAyf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 20:54:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7998211D163;
        Mon, 11 Sep 2023 16:56:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A3A6D1F38D;
        Mon, 11 Sep 2023 23:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694474407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Snvxo2P0yNaIi5ptaSVycgyop4uja1YqdxoLJrtrWv8=;
        b=UObtITlE/n8JJOmzDxCaqsdU7nYw3IEUWd/9FHP0KiZ36o3fok68y2pkIonUrBkwPuR674
        S/WHPIEG4KXtZINrFCTevvm/w3ZYrVpL4JVxsZStBagvtmiOI4lWb763Tkx/hTDwrp8aTC
        VYQp2SlM9K3gU8vhcceQhfQNxs6DjdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694474407;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Snvxo2P0yNaIi5ptaSVycgyop4uja1YqdxoLJrtrWv8=;
        b=//nTrIoTsQRfLCq8DgiGSOTrCkPynSEClk0e/SWV5dISSBY3yW4WIkX3iIrY5Er4Ut96/3
        2SJXw8BGdiufnmBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 878DA139CC;
        Mon, 11 Sep 2023 23:20:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pYq1DqSg/2RBOQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 11 Sep 2023 23:20:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Andrew Morton" <akpm@linux-foundation.org>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Chuck Lever" <cel@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Liam Howlett" <liam.howlett@oracle.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "David Gow" <davidgow@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 11/17] lib: add light-weight queuing mechanism.
In-reply-to: <20230911140439.b273bf9e120881f038da0de7@linux-foundation.org>
References: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>,
 <169444318342.4327.18355944158180782708.stgit@bazille.1015granger.net>,
 <20230911111333.4d1a872330e924a00acb905b@linux-foundation.org>,
 <4D5C2693-40E9-467D-9F2F-59D92CBE9D3B@oracle.com>,
 <20230911140439.b273bf9e120881f038da0de7@linux-foundation.org>
Date:   Tue, 12 Sep 2023 09:19:59 +1000
Message-id: <169447439989.19905.9386812394578844629@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 12 Sep 2023, Andrew Morton wrote:
> On Mon, 11 Sep 2023 20:30:40 +0000 Chuck Lever III <chuck.lever@oracle.com>=
 wrote:
>=20
> >=20
> >=20
> > > On Sep 11, 2023, at 2:13 PM, Andrew Morton <akpm@linux-foundation.org> =
wrote:
> > >=20
> > > On Mon, 11 Sep 2023 10:39:43 -0400 Chuck Lever <cel@kernel.org> wrote:
> > >=20
> > >> lwq is a FIFO single-linked queue that only requires a spinlock
> > >> for dequeueing, which happens in process context.  Enqueueing is atomic
> > >> with no spinlock and can happen in any context.
> > >=20
> > > What is the advantage of this over using one of the library
> > > facilities which we already have?
> >=20
> > I'll let the patch author respond to that question, but let me pose
> > one of my own: What pre-existing facilities are you thinking of, so
> > that I may have a look?
>=20
> Well, I assume that plain old list_heads could be recruited for this
> requirement.  And I hope that a FIFO could be implemented using kfifo ;)
>=20

Plain old list_heads (which the code currently uses) require a spinlock
to be taken to insert something into the queue.  As this is usually in
bh context, it needs to be a spin_lock_bh().  My understanding is that
the real-time developers don't much like us disabling bh.  It isn't an
enormous win switching from a list_head list to a llist_node list, but
there are small gains such as object size reduction and less locking.  I
particularly wanted an easy-to-use library facility that could be
plugged in to two different uses cases in the sunrpc code and there
didn't seem to be one.  I could have written one using list_head, but
llist seemed a better fix.  I think the code in sunrpc that uses this
lwq looks a lot neater after the conversion.

I wasn't aware of kfifo.  Having now looked at it I don't think it would
be suitable.  It is designed to provide a fixed-size buffer for data
with cycling "head" and "tail" pointers - typically for data coming from
or to a device.  It doesn't provide any locking support so we would need
locking both to enqueue and to dequeue.  Thus it would be no better than
the list_head approach, and the different interface style would make it
harder to use (an "impedance mismatch"?).  A simple summary might be
that kfifo provides a buffer, not a queue.

Thanks,
NeilBrown
