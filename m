Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C435AE73FE
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2019 15:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390263AbfJ1Oum (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Oct 2019 10:50:42 -0400
Received: from smtp-o-1.desy.de ([131.169.56.154]:56720 "EHLO smtp-o-1.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbfJ1Oum (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 28 Oct 2019 10:50:42 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Oct 2019 10:50:40 EDT
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
        by smtp-o-1.desy.de (Postfix) with ESMTP id D8DA2E0115
        for <linux-nfs@vger.kernel.org>; Mon, 28 Oct 2019 15:44:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de D8DA2E0115
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1572273893; bh=m/RBMG3PbSrFnbjq3ABvZVUxVmq9UAPGCKiscaSbh+A=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=JrWhvB0aNyDHbtUeuwpNkqIYV3+qY7MrI/6HFMHlkufuIlTe4/fXlLpfAmXQyAZD2
         NvB3vEVAoSZ3hTFxOXC30ugklfxbIv5q0jLSZ8Qo/3K286CRmk3AEKAP10315X/N2B
         rKHeqBj0ruMIDnoOTFrHz/Krr/3+zyDilJVMN1pE=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id D4DBE12020F;
        Mon, 28 Oct 2019 15:44:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-2.desy.de (Postfix) with ESMTP id AF94B10003A;
        Mon, 28 Oct 2019 15:44:53 +0100 (CET)
Date:   Mon, 28 Oct 2019 15:44:53 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Naruto Nguyen <narutonguyen2018@gmail.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <1589957450.8701645.1572273893609.JavaMail.zimbra@desy.de>
In-Reply-To: <CANpxKHHAngJWaW0uiOfUnBCi2Tv36h33dVg8pAuAmMcbnYzzJQ@mail.gmail.com>
References: <CANpxKHHAngJWaW0uiOfUnBCi2Tv36h33dVg8pAuAmMcbnYzzJQ@mail.gmail.com>
Subject: Re: NFS latency and throughput minimum requirement
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3847 (ZimbraWebClient - FF70 (Linux)/8.8.15_GA_3847)
Thread-Topic: NFS latency and throughput minimum requirement
Thread-Index: 9IKheuJ+WOm78oEoAM66FiGClybYUA==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Naruto,

NFS performance is a function with multiple variables:

  - CPU
  - kernel
  - TCP
  - Networks
  - Disk subsystem
  - File system

and every component has it's own set of knobs to turn...

I will inter the question: What is expected latency and throughput
of your applications? Can you identify the bottlenecks? At the best
try to reproduce the load with application itself or fio and then
go one-by-one and tweak the performance.

Regards,
   Tigran.
 
----- Original Message -----
> From: "Naruto Nguyen" <narutonguyen2018@gmail.com>
> To: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Monday, October 28, 2019 6:25:24 AM
> Subject: NFS latency and throughput minimum requirement

> Hi everyone,
> 
> Could you please advice me how to identify the minimum NFS requirement
> of latency and throughput on a specific system? I have some test cases
> to test performance of NFS and tune the system to have better NFS
> performance but I do not know how good or bad with my
> measurement/result.
> 
> Thanks,
> Brs,
> Naruto
