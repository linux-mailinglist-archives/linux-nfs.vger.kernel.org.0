Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D05831D0DD
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Feb 2021 20:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhBPTU0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Feb 2021 14:20:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49434 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229879AbhBPTUS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 Feb 2021 14:20:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613503130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=odB8fmKBAfP7x7ngeg8HM7YEzmJw+ADo5ztVFfxgle0=;
        b=eBdyXZcaDixY8C732v9Hx6gsAA1BpeWnoSFPYkgYZFYYDfmJUFXc80ArlyHdV7I5gQQB6L
        NjoQvzA45DW6nVxE8PHRwEBmBTE3jIL6nUulLqntrq6d1ZQstFWE7uYsVBihqKp+8kddz+
        E66MttlUN+jY6kD2r6xcAqd3VMWJM18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-ygxC5js_OP-BsqT-w6RPvQ-1; Tue, 16 Feb 2021 14:18:46 -0500
X-MC-Unique: ygxC5js_OP-BsqT-w6RPvQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00E748030C1;
        Tue, 16 Feb 2021 19:18:45 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-108.phx2.redhat.com [10.3.112.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93EB160C6B;
        Tue, 16 Feb 2021 19:18:43 +0000 (UTC)
Subject: Fwd: [nfsv4] VBAT: The 1st Virtual Bakeaton
References: <86e6ffdd-cbc3-594c-5199-016c61bd7912@RedHat.com>
From:   Steve Dickson <SteveD@RedHat.com>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     NFSv4 <nfsv4@ietf.org>
X-Forwarded-Message-Id: <86e6ffdd-cbc3-594c-5199-016c61bd7912@RedHat.com>
Message-ID: <68bd1d3a-d1d5-4dee-8e3b-0b89baf6ef22@RedHat.com>
Date:   Tue, 16 Feb 2021 14:20:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <86e6ffdd-cbc3-594c-5199-016c61bd7912@RedHat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

The official start of the VBAT is next Monday 
but the network is up and running and some problems
have already been found!

Please feel free to reach out to Me or Ben 
for any help on get hooked up to the VBAT network!

All the details are at: http://www.nfsv4bat.org/Events/2021/Feb/BAT/index.html

Hope to (virtually) see you there!

steved.

-------- Forwarded Message --------
Subject: [nfsv4] VBAT: The 1st Virtual Bakeaton
Date: Wed, 13 Jan 2021 18:45:02 -0500
From: Steve Dickson <SteveD@RedHat.com>
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
CC: NFSv4 <nfsv4@ietf.org>

Hello,

Happy New Years!

Ben started the conversations about virtual bakeathon 
and built a network we can use for a VBAT.

We were floated the idea of having it on the last week 
of Feb (Mon 22ed to Fri 26th) which people seems to
agree with... so... 

Lets have a virtual Bakeathon at the end of Feb!!!

I've update the nfsv4bat.org site [1] with
all the details on how to register and 
enable a host to used the VBAT network.

The VBAT network consists of VPN connections 
using IPv6 address to do the routing. Again
all the details are on [1].

Participant's communications will be run through a 
Discord server [2], which supports both audio and IRC
capabilities... Meaning we can talk and type 
to each other... Again the details are on [1].

This is the first attempt at a virtual event
so there are going to be bumps in the road,
but as a community I'm sure we can make this
work. Point being... if you find problems please 
try to come up with a solutions... not a complaint ;-)

The official testing start end of Feb but 
the network is up and running right now! 

So I *strongly* suggest you try and build a
host to used the network well be for the
end of Feb... (aka ASAP!)

Finally, I'm working on getting VBAT t-shirts
for registered participants to order...
free of charge... So registering early would 
definitely help the effort out

Let make this happen!!!

steved.

[1] http://www.nfsv4bat.org/Events/2021/Feb/BAT/index.html
[2] https://discord.com/

_______________________________________________
nfsv4 mailing list
nfsv4@ietf.org
https://www.ietf.org/mailman/listinfo/nfsv4

