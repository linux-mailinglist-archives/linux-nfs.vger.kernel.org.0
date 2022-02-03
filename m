Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B674A899D
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Feb 2022 18:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbiBCROj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Feb 2022 12:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbiBCROj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Feb 2022 12:14:39 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63754C061714
        for <linux-nfs@vger.kernel.org>; Thu,  3 Feb 2022 09:14:39 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id q186so5048382oih.8
        for <linux-nfs@vger.kernel.org>; Thu, 03 Feb 2022 09:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to
         :content-language:content-transfer-encoding;
        bh=LrgX/4FJsTFGD8VUqTd3GdqujKiFaUMn/WWaEchp7Tg=;
        b=hD4yt4YHCS7S9caJyhBHnb2jc3tPaAHk+j62zGvidsoMh8QdcdOI2SM1AnlgM9LA+u
         N5XoEOYttjE3v2jLDnZWT3WV07sPcfnxB9se4Fp/eqvfYykTX9TO1SRAfTt37xOAmlJ4
         zZ270dw5rUEvCX2uVgXDnzwgfsVM0EsRXKmW4jcWDzuCEJCrGbc7WZT0e3quW2TDU9w4
         6DdE8P6KlGKwq+z9vcUuqOYcJLIl4fAhcbvXx+Ey+X/hDFjUsB1QdN1UO50gBv3mnhqF
         2oBF+3Y3WX171lzd6vizT2uuC/3uy8sRAGxj4q/+X84JVtgszhPnn+D40q/5OFATCXXP
         QrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:content-language:content-transfer-encoding;
        bh=LrgX/4FJsTFGD8VUqTd3GdqujKiFaUMn/WWaEchp7Tg=;
        b=x5pimppkYk36cCQZt9Kf3LLlvwQaCZ+F7AZaCGsU/Q3PGWp1LtlXwCg6IH9teP+//p
         fIvMGF8/mfXrwXfmFVjpQkeadxGquEdspbWnVAaRXBjsYOppkvdb+MY7CqdgxuOgk1Bf
         ILj700U01rcm712XoP8w5H7A4VI+KmOuUeumhgnT8309AP/CzHwUd5SE4uJxV+nsOX37
         hvX1WwLTkBbJXC88bpxgXq6b1Am/nwPEXB2qNxsJh8Y4gu98mE39VxjTFiPeyWGAbBlK
         WvxxoPpFKq4E1DoGJ4+Qo51xqCTnq81SBL3SNP0KaK/cSqpcDPAK1WuwniA3I1rCklt6
         oLLQ==
X-Gm-Message-State: AOAM533JI6FQPZLopz/eBLlhOLcnoRPipAcY6bhXjY6UaxbZyzpABlvd
        yGYGAuf+rIiSFEZKSCOjp+Y=
X-Google-Smtp-Source: ABdhPJxfB6O+sHDSaZrjbA3J+SS1zdPmFLe/uUkYo+03lBKMEaBbYXXVLizn9Q+L7R1HJRgfFPZOqg==
X-Received: by 2002:a05:6808:144b:: with SMTP id x11mr8361326oiv.336.1643908478581;
        Thu, 03 Feb 2022 09:14:38 -0800 (PST)
Received: from [192.168.86.103] (cpe-68-203-6-244.austin.res.rr.com. [68.203.6.244])
        by smtp.gmail.com with ESMTPSA id ek4sm250570oab.23.2022.02.03.09.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 09:14:38 -0800 (PST)
Message-ID: <d460f165-ca49-afb8-08d1-398303dd2633@gmail.com>
Date:   Thu, 3 Feb 2022 11:14:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
From:   Bill Baker <webbaker@gmail.com>
Subject: Announcing the Spring 2022 NFS bake-a-thon (resend)
To:     nfsv4@ietf.org, linux-nfs@vger.kernel.org,
        winter-2021-bakeathon@googlegroups.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Greetings,

I am pleased to announce the Spring 2022 NFS bake-a-thon, April 25-29, 2022.    
You can find information on the website: 
http://nfsv4bat.org/Events/2022/Apr/BAT/index.html

As before, we will be running this event in virtual space.  Please note the VPN 
registration and setup instructions so that you can punch into the BAT network.

Look forward to seeing you (virtually) at the next BAT.
--
Bill Baker - Oracle NFS development
