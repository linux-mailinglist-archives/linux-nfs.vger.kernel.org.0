Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EC269E7F3
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Feb 2023 19:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjBUS7w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Feb 2023 13:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjBUS7u (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Feb 2023 13:59:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B769E2D16F
        for <linux-nfs@vger.kernel.org>; Tue, 21 Feb 2023 10:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677005945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nIWOMH194h+ioWljhqxTGvRo6gphvrTov0bIc5wYRfc=;
        b=QH7aGD175kMskOFbhBytELiHvM5Jwve60+mxSs+/R2yrCwOS+gILZDQ5Mq0e47/4BBeXgQ
        VZmGCBJgMDzOqvZ7jVjN2Sg2kkILydLRam90vtVfzZdPRZgAh3pxfoBd2Md6XbS/slRkbT
        o3buKy59voWIQw8Yf8IXMzFNdOUCeUw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-8iVZ5aiCMOOnU6xTeI474Q-1; Tue, 21 Feb 2023 13:59:02 -0500
X-MC-Unique: 8iVZ5aiCMOOnU6xTeI474Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2C6438149AA;
        Tue, 21 Feb 2023 18:59:01 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E6BD40BC781;
        Tue, 21 Feb 2023 18:59:01 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     =?utf-8?q?Florian_M=C3=B6ller?= 
        <fmoeller@mathematik.uni-wuerzburg.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Andreas Seeg <andreas.seeg@mathematik.uni-wuerzburg.de>
Subject: Re: Reoccurring 5 second delays during NFS calls
Date:   Tue, 21 Feb 2023 13:58:59 -0500
Message-ID: <1B586C15-908C-4B00-9739-9AD118F88BD4@redhat.com>
In-Reply-To: <7c7de5f1-fb6a-e970-99a2-4880583d8f6d@mathematik.uni-wuerzburg.de>
References: <59682160-a246-395a-9486-9bbf11686740@mathematik.uni-wuerzburg.de>
 <8a02c86882bc47c1c1387dba8c7d756237cb3f3f.camel@kernel.org>
 <3b6c9b8e-2795-74e8-aefa-d4f1ac007c3c@mathematik.uni-wuerzburg.de>
 <785052D6-E39F-40D3-8BA3-72D3940EDD84@redhat.com>
 <7c7de5f1-fb6a-e970-99a2-4880583d8f6d@mathematik.uni-wuerzburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 21 Feb 2023, at 11:52, Florian M=C3=B6ller wrote:

> Hi Benjamin,
>
> here are the trace and a listing of the corresponding network packages.=
 If the listing is not detailed enough, I can send you a full package dum=
p tomorrow.
>
> The command I used was
>
> touch test.txt && sleep 2 && touch test.txt
>
> test.txt did not exist previously. So you have an example of a touch wi=
thout and with delay.

Thanks!  These are great - I can see from them that the client is indeed
waiting in the stateid update mechanism because the server has returned
NFS4ERR_STALE to the client's first CLOSE.

That is unusual.  The server is signaling that the open file's stateid is=
 old,
so I am interested to see if the first CLOSE is sent with the stateid's
sequence that was returned from the server.  I could probably see this if=
 I
had the server-side tracepoint data.

But from what's here I cannot see the details to figure this out because
you've only sent the summary of the packet capture.. can you send along t=
he
raw capture?

I usually use something like:

tshark -w /tmp/pcap -i enps0 -P host server

=2E. then the file /tmp/pcap has the raw capture.  We can use that to loo=
k at
the sequence numbers for the stateid as sent from client to server.

However, if you use krb5p, we won't be able to see these details.  Only k=
rb5
or krb5i.  If the problem only reproduces with krb5p, we have to rely on =
the
tracepoints output on the client and server.

Ben

