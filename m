Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDAE6B1C35
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Mar 2023 08:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCIHYW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Mar 2023 02:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCIHYV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Mar 2023 02:24:21 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7445D8AF
        for <linux-nfs@vger.kernel.org>; Wed,  8 Mar 2023 23:24:16 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C0D9B5C011D
        for <linux-nfs@vger.kernel.org>; Thu,  9 Mar 2023 02:24:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 09 Mar 2023 02:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nubmail.ca; h=cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678346645; x=1678433045; bh=Jy
        JQmlen5cEkFA39ZNElJRyURgazpayuIp3dc6AsjNg=; b=iR6FHU9Vz8mWdLS5oo
        /cgYGdfcl89jT7/euiuXX+ZqixqtQ3Gl7wRWbDZfObialxj6gMMo3s+5FgnUCREc
        pe/SHhE5/24XnnS8rCQc0bVtzTtwVewl81q+BlWsGuDiJV3mQkkT5VGqxWPbRyv8
        yWbuTBdJZ7WTNb5UXJu77Fdkl9AQ2sWDxiBWsy2XDtsXCiFAfxBrFcBNi/o6X7Xy
        msVAkYqcdJelBQ9/LrPnM8WJjWyZpkLIQGgaVfom7W2APv/riZfeuot6pVRWE/6s
        2NHWyyB1hfCvVn85OG0kWG+DQlQFEuv4l9TOwFZg0ha1GBO7uULRqF/JpW+IPOIb
        wqQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678346645; x=1678433045; bh=JyJQmlen5cEkF
        A39ZNElJRyURgazpayuIp3dc6AsjNg=; b=UbvFkx7pV55hux3Qby8Wm8p1j1iiL
        +dL6SACVJB/Msxc5SV1pqErI1Fd7tTWvIA3ss8TS9N7HHDKc8POOhdQb9geFOFG7
        bsu6EFVdaOifBPGLa1joBxB89ie7nqZ3y1tgdbj84pkyBvfaPd3w2LyIechNyDTR
        EDnF8QjX+UzrCjoQsYN1fCaBwme9gRxESX1C9JmENnP6O9qX3Pcv3HUeHXLplxhq
        7NyXE0qsQbcqeSDljYUzwsDHXaK7ExwoqmK9fGaY4O80cPw1M1weJwObah1EvEux
        EhR+lqI7b4AOaNY8e0RWtOdiCZVGZFn0xNNqfhDq3jMQDPc5SleZa++uw==
X-ME-Sender: <xms:lYkJZByf31GgXh05JyHWUeQ0-9HHwhAyas1tThAzZM7Rp86nUtP9Tg>
    <xme:lYkJZBQD8AL2L8qU_T_8VedpdLmh7u2rbEAwsDiCoYauDL0_Z_MH7YcjM0ARxeKlQ
    DXGpBpMr73VvTqENOY>
X-ME-Received: <xmr:lYkJZLWfxQjGVl9Ihnnvjy_GBo4XfkmoxtfT_IJBUwIH__-guh0uvgWQIUJ-4HUY9lNNjUaBFOSXJtuUFf3YLbV2hQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdduhedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefkffggfgfhuffvtgfgsehtkeertd
    dtfeejnecuhfhrohhmpeetrhgrmhcutehkhhgrvhgrnhcuoegrrhgrmhesnhhusghmrghi
    lhdrtggrqeenucggtffrrghtthgvrhhnpeekvdegvdejuefgvdegudffteegheffkefgje
    egieduvdeghedthefffeeileekhfenucffohhmrghinhepnhhusgdrlhgrnhenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhgrmhesnhhusg
    hmrghilhdrtggr
X-ME-Proxy: <xmx:lYkJZDgKYb-v6PvUdH9ypVhEMkqAitk03_aP2kSqL7zOx6mlVOxRZQ>
    <xmx:lYkJZDBuY-MFKRsakbcRgqVzXSPT7KncP6PVEutmiEF169n3MzJocw>
    <xmx:lYkJZMKme9ukgtpB1sQqV8sx-L786TIifMBCIv744zasSUacWhz57w>
    <xmx:lYkJZG8EgsD-gDb_YF8earbiSYdmMjwWwDT_D7tNr9ilePr9-gIE2Q>
Feedback-ID: i8ce9446d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-nfs@vger.kernel.org>; Thu, 9 Mar 2023 02:24:05 -0500 (EST)
Message-ID: <ff66197f-8b60-5ff8-a2ac-8f5090b231cf@nubmail.ca>
Date:   Wed, 8 Mar 2023 23:23:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Aram Akhavan <aram@nubmail.ca>
Subject: nfs-idmapd startup race
To:     linux-nfs@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

I've been debugging an nfs server issue where id mapping was not 
happening correctly unless I restarted nfs-kernel-server and re-exported 
shares shortly after reboot. The main symptom is the following log 
entries from nfs-idmapd.service:

Mar 08 22:45:59 343guiltyspark.nub.lan systemd[1]: Starting NFSv4 ID-name mapping service...
Mar 08 22:45:59 343guiltyspark.nub.lan rpc.idmapd[620]: libnfsidmap: Unable to determine the NFSv4 domain; Using 'localdomain' as the NFSv4 domain which means UIDs will be mapped to the 'Nobody-User' user defined in /etc/idmapd.conf
Mar 08 22:45:59 343guiltyspark.nub.lan rpc.idmapd[620]: rpc.idmapd: libnfsidmap: Unable to determine the NFSv4 domain; Using 'localdomain' as the NFSv4 domain which means UIDs will be mapped to the 'Nobody-User' user defined in /etc/idmapd.conf
Mar 08 22:45:59 343guiltyspark.nub.lan rpc.idmapd[620]: rpc.idmapd: libnfsidmap: using (default) domain: localdomain
Mar 08 22:45:59 343guiltyspark.nub.lan rpc.idmapd[620]: rpc.idmapd: libnfsidmap: Realms list: 'LOCALDOMAIN'
Mar 08 22:45:59 343guiltyspark.nub.lan rpc.idmapd[620]: rpc.idmapd: libnfsidmap: loaded plugin /lib/x86_64-linux-gnu/libnfsidmap/nsswitch.so for method nsswitch

I wrote a little test program to mimic libnfsidmap's domain_from_dns() 
function, which causes the above message:

#include <netdb.h>
#include <stdio.h>
#include <unistd.h>
#include <errno.h>
extern int h_errno;
int main() {
     struct hostent *he;
     char hname[64], *c;

     if (gethostname(hname, sizeof(hname)))
         printf("gethostname error: %d\n", errno);
     else
         printf("gethostname: '%s'\n", hname);

     if ((he = gethostbyname(hname)) == NULL)
         printf("gethostbyname error: '%s'\n", hstrerror(h_errno));
     else {
         printf("gethostbyname h_name: '%s'\n", he->h_name);
     }
}

and added it as an ExecStartPre= to the systemd service. The output is:

gethostname: '343guiltyspark.nub.lan'
gethostbyname error: 'Host name lookup failure'

It seems dns resolution isn't quite working when the service is started, 
so I added Wants=network-online.target (and After=) to the systemd 
service. It still fails.
But if I then add a "sleep 1" to the ExecStartPre, everything starts up 
correctly.

Obviously there are many solutions, including the above and setting the 
domain manually in /etc/idmap.conf. But on principle I'd like to solve 
the root race condition and help others avoid the same issue.

I'm hoping someone can answer my open questions:

1. Why does libnfsidmap use gethostname() and gethostbyname() (i.e. why 
does it need a dns lookup on the hostname)?

2. nfs-server.service already has a dependency on network-online.target, 
but nfs-idmapd.service does not (and it starts first). Since id mapping 
can depend on DNS resolution (and seems to out of the box), why not add 
the dependency to the latter as well?

3. Since the network-online.target doesn't completely solve the issue, 
any ideas on how to fix the startup race without something haphazard 
like a "sleep"?

Thanks,

Aram

