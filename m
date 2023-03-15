Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A3A6BBFA0
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Mar 2023 23:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCOWK4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Mar 2023 18:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjCOWKz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Mar 2023 18:10:55 -0400
X-Greylist: delayed 570 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Mar 2023 15:10:53 PDT
Received: from smtpq4.tb.ukmail.iss.as9143.net (smtpq4.tb.ukmail.iss.as9143.net [212.54.57.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201051C5BB
        for <linux-nfs@vger.kernel.org>; Wed, 15 Mar 2023 15:10:52 -0700 (PDT)
Received: from [212.54.57.97] (helo=smtpq2.tb.ukmail.iss.as9143.net)
        by smtpq4.tb.ukmail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <trevor.hemsley@ntlworld.com>)
        id 1pcZBS-00063p-Jy
        for linux-nfs@vger.kernel.org; Wed, 15 Mar 2023 23:01:22 +0100
Received: from [212.54.57.108] (helo=csmtp4.tb.ukmail.iss.as9143.net)
        by smtpq2.tb.ukmail.iss.as9143.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <trevor.hemsley@ntlworld.com>)
        id 1pcZBQ-00044k-8M
        for linux-nfs@vger.kernel.org; Wed, 15 Mar 2023 23:01:20 +0100
Received: from [192.168.111.4] ([82.3.223.249])
        by cmsmtp with ESMTPA
        id cZBPpSw8CPjoOcZBQp6dHl; Wed, 15 Mar 2023 23:01:20 +0100
X-SourceIP: 82.3.223.249
X-Authenticated-Sender: trevor.hemsley@ntlworld.com
X-Spam: 0
X-Authority: v=2.4 cv=O8n//jxW c=1 sm=1 tr=0 ts=64124030 cx=a_exe
 a=7Y/zLBzgJ9hZK8ZgStTyBw==:117 a=7Y/zLBzgJ9hZK8ZgStTyBw==:17
 a=IkcTkHD0fZMA:10 a=k__wU0fu6RkA:10 a=20KFwNOVAAAA:8 a=P77aPiMhK8IHW1t27mAA:9
 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntlworld.com;
        s=meg.feb2017; t=1678917680;
        bh=/mEPAFTpDJ824cGXHPONRAB65CPJq9fyAhaLEfrrco4=;
        h=Date:To:From:Subject;
        b=Cq3LhNt/0Zz4a7WN+GBKV+e6vCqjMPo25ZxPM4E8Pa+6Os3NbAmY7wE8CHSvaL7BI
         IIyGhIYXRhG6PV6iPbRtCK6w6vYe9MhAvj7PDKk5LXgIf15yWIgHZ3XTEtytgxo2tB
         tOzCw6X72t1A7DsGhosNWtXQ35019+mj3CJJb4760GroPDAD+dm1sqRbbx2PxVQcLW
         3p6Mr7J1efYBfdRrXt0sgkst18Me6DsMYfP7A7lVEW3udJgheLUj3SZ7lTxLwq/AvG
         DVu/uY2CAMCh7/s+Kn34EtcD3Ja94cXzkxoFSbeNBGu4f4Vpi8Lv4md9U4Wwi/MGEK
         tBzJWbmmZxQCQ==
Message-ID: <6d3d381d-84b4-98c7-e6b2-a3b1ad25409b@ntlworld.com>
Date:   Wed, 15 Mar 2023 22:01:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-GB
To:     linux-nfs@vger.kernel.org
From:   Trevor Hemsley <trevor.hemsley@ntlworld.com>
Subject: Crash in nfsd on kernel > 5.19
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDu8tyK2TLaInHMygz47ATg5+sN/nzMfXAgVd+4bkBXt4jznXDs1/s4PSgsdbFizN1szlHpSxPT1F4d9o2d6dirKupvhD35RjksZsIt/cw3fjB0Zb+QY
 s6yNZWLi4Di0tAPwXzEaNzu5rKcQz1Z5IYYizYBku9j6WRZUiaJJzJfXriu6Opnju3boqtoupgfpm2SvkKmRYecbeM2aruSCPKs=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Hi

I am not subscribed to this list so please cc me on any replies.

I have a problem using a media player called Kodi when it plays a media 
file that is hosted on an NFS share. Reverting to 
kernel-5.19.16-200.fc36.x86_64 fixes the problem so I suspect this is a 
change made between 5.19 and 6.0.

I'm running libreelec 10.$latest as the client, which is distro 
specifically to allow kodi to run, and the problem is easily 
reproducible from there. All it takes is to play any movie/tv episode 
from an NFS share on a Fedora 36 host and attempt to fast forward the 
motion. Within a second or two, it crashes nfsd on the host. This 
started happening when Fedora updated from kernel 5.19.x to 6.0.x. My 
first crash was on kernel 6.0.9 and it has happened with each 6.0.x 
minor update and with 6.1.x since.

I raised a bugzilla entry 
https://bugzilla.redhat.com/show_bug.cgi?id=2148276 to report this and 
it has seen no traction. There are a few crashes detailed in the ticket. 
Several others have "me too'ed" that bugzilla and the latest example is 
from an untainted kernel 6.1.15-200.fc37.x86_64. I figure it's time to 
try reporting it here instead.

Am happy to test any patches if I can make them apply to the current 
Fedora 6.1.18 (latest) source

Trevor
