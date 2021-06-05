Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58E539CB08
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Jun 2021 22:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhFEUyQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Jun 2021 16:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEUyP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Jun 2021 16:54:15 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74F8C061766
        for <linux-nfs@vger.kernel.org>; Sat,  5 Jun 2021 13:52:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id f11so19387792lfq.4
        for <linux-nfs@vger.kernel.org>; Sat, 05 Jun 2021 13:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-transfer-encoding;
        bh=oxB8EFNz7ZGsV89abezcL0p5bFXw37OEV41A0+RMBDo=;
        b=MZCPhOe1TzFgt6NFmfD9kkcWLTajpabwTWCx6hhZBw2V7i3RsyrNp+UBU7Qg+AFfvU
         kR86mi/9cPOzzQjEgxY5FZOpjjJSCqTQ3cvrnAxPIwHKKUTXEdqFTH4cbY22qczANWCs
         vRyfl0YySZN3bK8HoZ+2I6GYkvQcqKZtGIh/8ccJjwmsIBcSXgFhocGDI/Ds3hxu7M8B
         8iAT0HV3Zh1vjdMHC9lJAL8lzRnPfImt9t72O/ap3K88Y+hqtxPTeWMI7AE/GGssrJsq
         TII9Td4kxjiUK44er782gEepsYVFX59hII8/s5sjoOWFdW2cev/p/dL7ZTe5SKIthplf
         wUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:content-transfer-encoding;
        bh=oxB8EFNz7ZGsV89abezcL0p5bFXw37OEV41A0+RMBDo=;
        b=XgrrM1J6614q3dRiNuGyWxVDxy/1de36+Rc3pKP1AzlLqK/MxHRuh5H6IXKbVZbbdf
         X450dA4emMFgXOz2vthKdwqgIQNtVZk2X+36+6EujUGS6TdkcFh/LBbizBESmmPWshFJ
         bQ2rDkgpcwubDGvazzR2ZRXNLsu1ejvycYqYCArngWB7M+SAgbYOp1F/49EdqPzzBYQR
         Hz9/Iy9JKP6HAfx2jFolFQi+oxgXjVmLBRKvUEJsF74MOzfcEgFZ2tQCKByhXaYNGWZX
         JPETV8+YnRBXvTFQo6sldC1y4JC9W28Hxj62Qh3GoJqshZrgnfqUhFm/pt/Ek/v0KKEF
         HALQ==
X-Gm-Message-State: AOAM530KAGxJlsMl4PtFWl/J8EiU7zez32IoQslcHmPY4gZBxq4snbTy
        IGHtCFrvSbMPkMxyMzr9MvPRYK85mceMJw==
X-Google-Smtp-Source: ABdhPJwmXa3NtnWlPmYhdWuYld2teKfaEbW8iR8PAad4wk+WD5aOwmLkoHmjcnMFOK0uWmXX9Q8B4g==
X-Received: by 2002:a19:7b15:: with SMTP id w21mr4335019lfc.162.1622926330789;
        Sat, 05 Jun 2021 13:52:10 -0700 (PDT)
Received: from [192.168.0.91] ([188.242.181.97])
        by smtp.googlemail.com with ESMTPSA id s19sm1168011lji.79.2021.06.05.13.52.10
        for <linux-nfs@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 05 Jun 2021 13:52:10 -0700 (PDT)
Message-ID: <60BBE66E.6080806@gmail.com>
Date:   Sun, 06 Jun 2021 00:02:38 +0300
From:   Nikolai Zhubr <zhubr.2@gmail.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.2.4) Gecko/20100608 Thunderbird/3.1
MIME-Version: 1.0
To:     linux-nfs@vger.kernel.org
Subject: Continuation of failed RPC request after unmount
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

I'm debugging some likely buggy network device driver. Let's say the 
driver erroneously looses some packets (under certain conditions). One 
of important tests is being able to mount and use NFS share (as a 
client). I'm currently using kernel 4.14.221 and NFS v3 in UDP mode.

While testing, I've noticed some strange NFS behaviour. If some NFS 
request (file read) obtains no response (let's suppose due to 
connectivity issue), such request will be resent periodically (in hope 
to eventually succeed). This is expected. Now I observe, that after I 
unmount the NFS share (successfully), the failed requests still keep 
being resent, apparently infinitely (Confirmed by e.g. Wireshark), 
surviving also ifdown and ifup. So basically, I've found no way to get 
rid of them other than reboot.
Is this a known behaviour? Is it by design? Does it make any sense?


Thank you,

Regards,
Nikolai
