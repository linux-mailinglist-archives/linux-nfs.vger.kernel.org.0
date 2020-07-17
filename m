Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB402241DB
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jul 2020 19:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgGQReJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jul 2020 13:34:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35255 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726090AbgGQReJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jul 2020 13:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595007248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bOyqHCdVIUnftZwuCNgV8jNJU7xlGfEyVJxbtqvAbzs=;
        b=HgZb7SHJpP03KFGb6Sp5Y1KNM7HK0GH64ruAvobPq5Y/Zc3Wx2s/BMHsGEaLa+B3ScByfG
        RixqDPd6o74DonV1vL1rDl1qx3v3oKifwspFeOVcM/K4JDw9efKGNSGNOfAFkolTthprQ1
        8z6KF9CBlRzLg9Lm+ONTFQr1YjiQAjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-vuT1nszuNw6ihez07tRl5Q-1; Fri, 17 Jul 2020 13:34:06 -0400
X-MC-Unique: vuT1nszuNw6ihez07tRl5Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04361800464;
        Fri, 17 Jul 2020 17:34:05 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-147.phx2.redhat.com [10.3.113.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2632119724;
        Fri, 17 Jul 2020 17:34:04 +0000 (UTC)
Subject: Re: nfs-utils README updates
To:     Doug Nazar <nazard@nazar.ca>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <34f07da7-250d-f354-bf59-74b9f1a0e16f@nazar.ca>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <0555b3d1-8cbe-c3d8-2214-2bf7d3d65286@RedHat.com>
Date:   Fri, 17 Jul 2020 13:34:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <34f07da7-250d-f354-bf59-74b9f1a0e16f@nazar.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey Doug,

On 7/16/20 5:36 PM, Doug Nazar wrote:
> I was looking through the README to ensure my systems followed the correct setup and noticed a few things.
> 
> Looks like the reference to libnfsidmap can be dropped.
> 
> It looks like nfsdcld is again the correct setup for client tracking. A section should be added to SERVER STARTUP to include nfsdcld on NFS4+ servers.
> 
> Should it mention which modules are required before starting? I've had to locally add 'auth_rpcgss' to my startup scripts or svcgssd will bail on startup.
> 
> Any other changes or best practices that should be mentioned before I send a patch?

Yes... the README is dreadfully out of date... although most of it has
not changed but a lot has... esp when it comes to the systemd set up..
although the systemd/README is pretty accurate... Maybe a point to
the systemd/README in the top README would be good. 

What script did you have to add 'auth_rpcgss' to? 
It should be automatically  be loaded when the sunrpc 
module is loaded.

Thanks for taking a look!

steved.

 

