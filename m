Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFC7444D9
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2019 18:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfFMQj6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jun 2019 12:39:58 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:43986 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730585AbfFMHDd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jun 2019 03:03:33 -0400
Received: by mail-pg1-f182.google.com with SMTP id f25so10376327pgv.10
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2019 00:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hbaac4bEx/YHKNPzmAOafy4iy0z6abuV+YZoDAliGWs=;
        b=eYb391UUXAujMbKfyGwY1ElNG6f6+sjD/q7BOiS9NcRlOVSLTFX7YxCfLHUrp9NX6k
         0ZM6ToymoGea5cSYdXrQjpY9MhfJvA1EjUKQocp9TDAdXLKHte1mNRRpYCqTTxdt7FE3
         oeBTnmOdQTfry7fQLgt15oYzKw/fE2fiMFgyivX0XI0tWEo8gsMbg2JrlSTsrATtQ7ax
         FY6JjDAv1pO0Io3R3SWe4uq+uUjXimbuT0b5BIx2eA0BMqFUd925cuJutXOAm8wd0Ozx
         ehzMI1IYvL8pmWHBoI0JAJv7FXq7Zfa1e2XNcngcjH0aVyyd6LB6WKv/lJ3rmDRzxWRA
         8NXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hbaac4bEx/YHKNPzmAOafy4iy0z6abuV+YZoDAliGWs=;
        b=btJrfCPCfQpyeuMVWfojXXBUh00fUwo88XEOnTFY31a4OKzHpaIzfH4L8Xc/01VMVI
         LE7oJAeh8zaIairvrQL7JroBgFiR3mI9tOyLjmI3qu8PjIynhaf4qiON15Q+W035LeVR
         prkTsILRhAghDtcSqwGr5AmUBoywvveY3r29nPs9ntP6VELz/EZB0fhYFfCZSfUlsBdl
         tXK+VhOFrTEdKwYSIr/w2UDMPlFvTHuBGsThC46rJmFUOntnupkkKNzd8SBVD9sEgm7v
         5Pp9m5rvBbKpE+odESGV+Dhafly19G4Rkqt2bxx/J5Qkmb/vTT7cH4A3OnmT+jcnhyCi
         PDVw==
X-Gm-Message-State: APjAAAX6ge8qZ2Ks43cwsCJSY2ise6AcQzwpHnNMefXADT1AeYmzEJqT
        GxnfG55byILPcLhqG1i/+f2OEqt/
X-Google-Smtp-Source: APXvYqy0C991JU7uDVGELs+vYUtwPFGCvCg5LyoTFigYSmllBINmuxTN+a1kWF/Ip5KdvL6N/EVOpg==
X-Received: by 2002:aa7:914e:: with SMTP id 14mr39627496pfi.136.1560409412928;
        Thu, 13 Jun 2019 00:03:32 -0700 (PDT)
Received: from [0.0.0.0] ([47.244.216.228])
        by smtp.gmail.com with ESMTPSA id c124sm1622988pfa.115.2019.06.13.00.03.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 00:03:32 -0700 (PDT)
Subject: Re: Can we setup pNFS with multiple DSs ?
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-nfs@vger.kernel.org
References: <71d00ed4-78b8-cefb-4245-99f3e53e5d2a@gmail.com>
 <28D4997E-0B02-4979-9DE3-7E87A7FD7BA1@redhat.com>
From:   Jianchao Wang <jianchao.wan9@gmail.com>
Message-ID: <f4e71030-85a4-1e93-9e29-9ebf92260b12@gmail.com>
Date:   Thu, 13 Jun 2019 15:03:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <28D4997E-0B02-4979-9DE3-7E87A7FD7BA1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Ben

Thanks so much for your kindly reply.

On 2019/6/12 20:07, Benjamin Coddington wrote:
> Hi Jianchao,
> 
> On 12 Jun 2019, at 3:55, Jianchao Wang wrote:
> 
>> Hi
>>
>> I'm trying to setup a pNFS experiment environment.
>> And this is what I have got,
>> VM-0 (DS)      running a iscsi target
>> VM-1 (MS)      initiator, mount a XFS on the device, and export it by NFS with pnfs option
>> VM-2 (Client)  initiator, but not mount, running a blkmapd
>>                mount the shared directory of VM-1 by NFS
>>
>> And it semes to work well as the mountstatus
>>             LAYOUTGET: 14 14 0 3472 2744 1 1381 1384
>>     GETDEVICEINFO: 1 1 0 196 148 0 5 5
>>      LAYOUTCOMMIT: 8 8 0 2352 1368 0 1256 1257
>>
>> The kernel version I use is 4.18.19.
>>
>> And would anyone please help to clarify following questions ?
>> 1. Can I involve multiple DSs here ?
> 
> Yep, you can add a new iSCSI DS with another filesystem and keep the same
> MD.  The pNFS SCSI layout has support for multi-device layouts, but I don't
> think anyone has put them through the paces.
> 
> The sweet spot for pNFS SCSI is large-scale FC where the fabric allows nodes
> different paths through different controllers.  I expect the do-it-yourself
> with iSCSI target on linux to have a bit more limited performance benefits.
> 
>> 2. Is this stable enough to use in production ? How about earlier version, for example 4.14 ?
> 
> Test it!  It would be great to have more users.
> 
> It would also be great to hear about your workload and if this shows any
> improvements.

Our workload includes large video files or massive small picture files from multiple clients
I will try to setup an environment in real hardware and see what will happen then

> 
> Last note - with SCSI layouts, there's no need to run blkmapd.  The kernel
> should have all the info it needs to find the correct SCSI devices.
> 
> Ben

Regards
Jianchao
