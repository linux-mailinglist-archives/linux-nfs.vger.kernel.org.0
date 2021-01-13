Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CDB2F55E3
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jan 2021 02:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbhAMXql (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jan 2021 18:46:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23481 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729592AbhAMXpf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jan 2021 18:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610581449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=me++wfyuprRTfVxtE48t4pcIdFIEwaWTHqD+TIiLRhI=;
        b=RY/mQQQE/4qnzrXkHXZ6mMsifWB71rJtS0HDpdE3n7kSzvwnUy/8SPJBBRRHLRKtBIkeGM
        mqul7WK9BGHHQ9flcjU2P6tqTr5zX320Emz7LQ0wlXGTTjCzuXcV8aesXvTHo4Aq6XDk81
        yQu9zlL3Z0zIAEl/FJe0jD4AzRz6X8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-g4T5yUJGPKGxgzAa60tkog-1; Wed, 13 Jan 2021 18:44:06 -0500
X-MC-Unique: g4T5yUJGPKGxgzAa60tkog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93B37100F340;
        Wed, 13 Jan 2021 23:44:05 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-152.phx2.redhat.com [10.3.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B6E210016F7;
        Wed, 13 Jan 2021 23:44:05 +0000 (UTC)
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From:   Steve Dickson <SteveD@RedHat.com>
Cc:     NFSv4 <nfsv4@ietf.org>
Subject: VBAT: The 1st Virtual Bakeaton
Message-ID: <86e6ffdd-cbc3-594c-5199-016c61bd7912@RedHat.com>
Date:   Wed, 13 Jan 2021 18:45:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

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

