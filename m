Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593F67D8A26
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Oct 2023 23:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjJZVSJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Oct 2023 17:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjJZVSI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Oct 2023 17:18:08 -0400
Received: from smtpdh19-1.aruba.it (smtpdh19-1.aruba.it [62.149.155.148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58964C0
        for <linux-nfs@vger.kernel.org>; Thu, 26 Oct 2023 14:18:05 -0700 (PDT)
Received: from [192.168.50.162] ([146.241.115.208])
        by Aruba Outgoing Smtp  with ESMTPSA
        id w7jtq9wTFpgXYw7jtqRs3p; Thu, 26 Oct 2023 23:18:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1698355082; bh=eht8FEhvlldvOSlASsfNKWy1iy3jx+JBUvRnwz6XsKA=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=FvlaRswReG9ksDQ24akMalcaGTla8n6MureyfOVgKFslzpl/dQqpQzz9+Luh/aFt3
         M6iX3dplmOf530L+Cf4RNZ22oz8dB/ibR8XyuFg396ermLqqRshkhfyHuoiOKSAeLF
         Uo1RCbuCbiNDLrIWASNt7hRj+t5QznU8yygYyvYyuYjXj/4Gf5iUnN2KDW2TbOlmu5
         WT4Q8OQrI0N0Y4ox2NqPPgEgVvSM73VMYF55qJDTK9z9JwLCVFOM1rJmgezpZqrhew
         +PNCwolCOtOqPTaQRohb926gjLzMXPiJIvcT14wSSntijzmT52h3tm8QpW67HY4vQT
         2pvrCuWCpeI7Q==
Message-ID: <98066647-bcc8-4231-b6d8-2eff4a1d48fe@benettiengineering.com>
Date:   Thu, 26 Oct 2023 23:18:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [nfs-utils 1/2] Fix build failure due to glibc <= 2.24 and check
 for Linux 3.17+
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-nfs@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Steve Dickson <steved@redhat.com>
References: <20231026114522.567140-1-giulio.benetti@benettiengineering.com>
 <20231026194712.615384-1-pvorel@suse.cz>
Content-Language: en-US
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <20231026194712.615384-1-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKX+IqL4nFlag5lKRTEKos5w7sg2/5/4BexnBaU3VRvaOZY5fuRWywUzHibzOCjDHgQkk38IqM0dN44/CoUZJiokhvmTzOTV3BDCPVa5qYZGb1KpkP/m
 d1QSQ3P4QEzEUDhuePmjyxQLFh/7Qyu15oj8xEdrOdDwbZXFCGK2BZCpbCgxvCHxPDFyWn/PWUpDzI35R8YMTte3T3y6IwWa01TFTVn6ygEmmI7p9FvXSZMA
 8u1UE3GIO2i76bU4UP31jVpeJcAd8nDcgUMHHfYsml4gUHjhoZYvWlzsdyTcu4cPCkjTtUCTjPJeykAiaW+hCw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Petr,

On 26/10/23 21:47, Petr Vorel wrote:
> interesting, I yesterday sent patch [1] solving the same problem (although it
> might not be that obvious from the patchset name). Let's see which one will be
> taken.
> 
> Kind regards,
> Petr
> 
> [1] https://lore.kernel.org/linux-nfs/20231025205720.GB460410@pevik/T/#m4c02286afae09318f6b95ff837750708d5065cd5

I totally forgotten to check Patchwork before working on it. Your patch
looks good, better than mine. Maybe you can improve the part of the
syscall because it's not always available. You can then send a patch for
Buildroot too with the patch you've pointed since there you're
nfs-utils package Maintainer too.

-- 
Giulio Benetti
CEO&CTO@Benetti Engineering sas
