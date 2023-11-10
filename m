Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801307E8158
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 19:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjKJS1Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 13:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346453AbjKJS0q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 13:26:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C055C37AFF
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 05:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699624159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EPfKlNuwR/GM48Y/IAehJMI4l0NQ5dt7dnnNlpSYYGw=;
        b=UXOqPavSnMyP7ehhWJrsVeaPJMWp9dPWNgdCdWkl3PvzFd5xgHinDTFHAiubW7auZ7TB2T
        6XyfxJFDN+Qeudt4SVmfiqQdW2ipn9ow4hsCsSEIv7QTMATvHlRZv0KyDjEixbovcLyBez
        bny3Xp0pzmX0MyJ0k2eQyryrh9CK9ec=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-iEvqUTrCONm0ch9IZfQeBA-1; Fri, 10 Nov 2023 08:49:17 -0500
X-MC-Unique: iEvqUTrCONm0ch9IZfQeBA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE4CB811E7B;
        Fri, 10 Nov 2023 13:49:16 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B0732026D68;
        Fri, 10 Nov 2023 13:49:16 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Martin Wege <martin.l.wege@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4 referrals - custom (non-2049) port numbers in fs_locations?
Date:   Fri, 10 Nov 2023 08:49:14 -0500
Message-ID: <2EA6162E-1CF9-49E8-8A05-9E5246606F89@redhat.com>
In-Reply-To: <CANH4o6NzV2_u-G0dA=hPSTvOTKe+RMy357CFRk7fw-VRNc4=Og@mail.gmail.com>
References: <CANH4o6Md0+56y0ZYtNj1ViF2WGYqusCmjOB6mLeu+nOtC5DPTw@mail.gmail.com>
 <DD47B60A-E188-49BC-9254-6C032BA9776E@redhat.com>
 <CANH4o6NzV2_u-G0dA=hPSTvOTKe+RMy357CFRk7fw-VRNc4=Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10 Nov 2023, at 2:54, Martin Wege wrote:

> On Wed, Nov 1, 2023 at 3:42 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> On 1 Nov 2023, at 5:06, Martin Wege wrote:
>>
>>> Good morning!
>>>
>>> We have questions about NFSv4 referrals:
>>> 1. Is there a way to test them in Debian Linux?
>>>
>>> 2. How does a fs_locations attribute look like when a nonstandard port
>>> like 6666 is used?
>>> RFC5661 says this:
>>>
>>> * http://tools.ietf.org/html/rfc5661#section-11.9
>>> * 11.9. The Attribute fs_locations
>>> * An entry in the server array is a UTF-8 string and represents one of a
>>> * traditional DNS host name, IPv4 address, IPv6 address, or a zero-length
>>> * string.  An IPv4 or IPv6 address is represented as a universal address
>>> * (see Section 3.3.9 and [15]), minus the netid, and either with or without
>>> * the trailing ".p1.p2" suffix that represents the port number.  If the
>>> * suffix is omitted, then the default port, 2049, SHOULD be assumed.  A
>>> * zero-length string SHOULD be used to indicate the current address being
>>> * used for the RPC call.
>>>
>>> Does anyone have an example of how the content of fs_locations should
>>> look like with a custom port number?
>>
>> If you keep following the references, you end up with the example in
>> rfc5665, which gives an example for IPv4:
>>
>> https://datatracker.ietf.org/doc/html/rfc5665#section-5.2.3.3
>
> So just <address>.<upper-byte-of-port-number>.<lower-byte-of-port-number>?
>
> How can I test that with the refer= option in /etc/exports? nfsref
> does not seem to have a ports option...

Just test it!

I thought the nfsref program actually populates the "trusted.junction.nfs"
xattr, which is part of the "fedfs" project's metadata to link filesystems
together.  I don't think that's what you want here.

Chuck - am I right to say that the nfsref program does not populate
nfsd4_fs_locations on knfsd?

Ben

