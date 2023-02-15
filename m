Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B714769777E
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Feb 2023 08:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjBOHlx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Feb 2023 02:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjBOHlw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Feb 2023 02:41:52 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB6731E37
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 23:41:51 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id i4so4577706vkn.13
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 23:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EWO2WwU1aPvnvyMXizPejR9mEn1hbui3LW+YIbdNIt4=;
        b=G9Qtom1s6NGIvdOMz8qO6cgsWTiCsYY7vhGeSvTREsEm4pdBB1uhDncThXZJjcj3Nz
         Dv2o5cjqx27cMOYmGqWKxqAZ7yDcIHzEgzwZDCknmeWR6rANKGqGKORgZqoxl5k0QrTZ
         /K/r87ZArGLTVtCpg85HsxR76wWtHljJx/KflazA5r9j0PaEORcbPmjNPNzShiPByf/D
         iKTMuLjbpase4ezvQebTexs5lm3fefI6pVrazxLhlaCLqZiWyKyoBZAsQIZXCuz8cXvQ
         NLDa+uBOCfdIbWGovnWktZRq+3hzBSLPg2HQJMnHzD2Jpp+8A5fqtO7dtyiYvMeNQPy5
         itaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWO2WwU1aPvnvyMXizPejR9mEn1hbui3LW+YIbdNIt4=;
        b=FR5lap939eN+rDnuuyf15+KcHizHmeGFvPU6ocubwJv25ZNmaNTp95zz9ie9YGfjT0
         dDQEl0n7w/FMFSWTBVB9ok8rOtfhPL594w5aPyPLWQjaHpa9Xy4sJ2xSuI7oa1ZQzohT
         bizOeqkqMnAyrZL2RZmwu5aNQc5sxGok60W7tnqUf/Aao5pCHcw8l4iJxKMqW9RwnK2e
         yCHaiyubTy9kdCV3ufnev9X0UcFGLlVeL1asp0bMUhA0ScItUUkMcUQQFg2ZPqYysVAM
         HhfAjgDtcHUWavgH1bUvy+A7o1iz5RIkwAlihB/QFOEYCN+srVZgFA/aTefrO3UgBe3z
         jDUA==
X-Gm-Message-State: AO0yUKUeoqsV7BfGvZb+TzVmzNVtWKvtiVVIp7iRnkiUAyxg8KQRrBCK
        DQD+qzviZf/nRuKRF+m1V3N50TdG1Aq1l1jOzq+EyDc2vo4=
X-Google-Smtp-Source: AK7set+IPyoUm5g+C+is/3C5BI4jP90ZyCxlBu6ARwAQH8LlsHln3bxtZUwbhRJOm1DOVjBpxdIDRRhvGJ/W4HgbCME=
X-Received: by 2002:a1f:b406:0:b0:3d5:9b32:7ba4 with SMTP id
 d6-20020a1fb406000000b003d59b327ba4mr174994vkf.15.1676446910533; Tue, 14 Feb
 2023 23:41:50 -0800 (PST)
MIME-Version: 1.0
References: <CAM=QnTEUcH2KVWp62Y7=Sh0zYXtptuEV5u2JzNOtFAbNU_c9ow@mail.gmail.com>
In-Reply-To: <CAM=QnTEUcH2KVWp62Y7=Sh0zYXtptuEV5u2JzNOtFAbNU_c9ow@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 15 Feb 2023 09:41:39 +0200
Message-ID: <CAOQ4uxg8g=L6e88XgCB-aKrw2abiJxBVem65u_0u1BxRgFOAvA@mail.gmail.com>
Subject: Re: [Lsf-pc] LSF
To:     Gatsi Trymore <gtrymore@sarao.ac.za>
Cc:     lsf-pc@lists.linux-foundation.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 15, 2023 at 9:14 AM Gatsi Trymore <gtrymore@sarao.ac.za> wrote:
>
> Good  Day Attendees
>
>
> My name is Gatsi Trymore. I work for an Astronomy organization which
> facilitates the  biggest scientific project (MeerKAT Telescope) in
> South Africa. I am part of the Software Team and I work as a Senior
> Software Site Support Engineer at The South African Radio Astronomy
> Observatory (SARAO, https://www.sarao.ac.za) not only facilitates the
> MeerKAT telescope but also facilitates other projects such as the
> Geodesy and VLBI activities. SARAO contributes to the infrastructure
> and engineering planning for the future Square Kilometer Array (SKA)
> Radio Telescope. SKA when completed will be the biggest radio
> telescope in the world. I am part of this exciting project!
>
>
> I hold a BSc (Honours) in Information Systems Degree. I am a certified
> RedHat Systems Administrator(RHCSA) as well as an RedHat Certified
> Engineer(RHCE). I have been working with Linux Servers for
> approximately nine years. I have worked with RedHat Linux and Ubuntu(
> Debian) Systems as well as the Proxmox Virtual Environment. I have
> experience configuring the Network File System (NFS server) technology
> in a client-server environment. At the moment we are running Ubuntu
> 22.04 on our NFS servers and Ubuntu 20.04 on the NFS client all
> running NVFSv4.
>
> I use automation tools like ansible and python scripting to automate
> some tasks to reduce mistakes and also enhance our working processes
> as well as for configuration management.
>
> On Linux servers I implement hardware RAID systems on Dell servers. I
> create Linux file systems on disk partitions and configure Logical
> Volume Management on Linux amongst other tasks. I also create Ceph
> storage clusters on our Linux servers.This is done to have the
> flexibility to expand storage volumes and capabilities on our servers
> for optimisation purposes.
>
>
> Having been in the field for almost a decade, I would like to
> contribute the knowledge I have gained working as a Linux
> administrator.  To contribute ideas to the Linux development community
>  as well as to share challenges and complexities that I have
> encountered during my journey. I would like to impact the community in
> this regard.
>
> I also look forward to learning from my fellow peers as well as to
> improving my Linux systems at my workplace with possibly learning
> about better technologies or methods to take advantage of the new
> improvements in the new Linux kernels.
>
>
> I am very well acquainted with the Network File System(NFS) and would
> like to share this knowledge. Please grant me the opportunity to do
> so.
>
>
> Network File System (NFS) is a networking protocol for distributed
> file sharing. A file system defines the way data in the form of files
> is stored and retrieved from storage devices, such as hard disk
> drives, solid-state drives and tape drives.
>
>
>  NFS is a network file sharing protocol that defines the way files are
> stored and retrieved from storage devices across networks.
>
>
> I would like to discuss our NFS server and client use case and the
> problems I have encountered and how I resolved them as well as suggest
> improvements to the  Linux NFS technology going forward. We have had
> issues with the NFS server where the server and the client were
> running different versions of Ubuntu and the clients ended up not
> communicating with each other. The clients were on an older version of
> Ubuntu and we had to upgrade the NFS to the latest version and
> remounted all clients and the problem was resolved.
>
> We run an NFS server in production running on Ubuntu 22.04 that serves
> 14 Linux Containers(lxc) running Ubuntu 18.04 and 10 Proxmox  Virtual
> Environment Server (pve) running Proxmox 7.
>
> I would like to discuss more on the NFS Linux technology.
>
>
> Yours Sincerely
>
> Trymore Gatsi

Hi Gatsi,

LSFMM is a summit for Linux kernel developers to discuss development
issues. This is not a summit to bring up ideas.

If you are not a contributor to Linux kernel or have never posted patches
for Linux kernel, you will not receive an invitation to attend.

If you have ideas for NFS development you can post them to the
NFS devel mailing list to get feedback.

Thanks,
Amir.
