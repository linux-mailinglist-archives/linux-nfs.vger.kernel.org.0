Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487FC492E71
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jan 2022 20:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237894AbiART0b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jan 2022 14:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbiART0b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jan 2022 14:26:31 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA60C061574
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jan 2022 11:26:31 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c66so309833wma.5
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jan 2022 11:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K0UTNyFjnWAm81T+6T7MV8PAIP8Ov1M1CXNQN9e1iUc=;
        b=xEpqdoyHuqEFG0TTS3+IC7Yrdn2Lv0saIYOMzIcW4ZONZih7xEXzIs8rp3rMFkm8AR
         D+7D4P27Y8pfMwkM8e60mBLsQlmDBexBcCvgymYTFS43O0t9FUPZ7KunzoWpoZT9JNVj
         hyLYs/TXjvJ9JQ0mY8EfGsUEVBF9hJAiqaMEAK6DIuIskduco7GDkMithgv0dX3P2kBf
         GEg00T+Hh+4PtbjbtBNObj38DHdbiSMBsGZkEZAvcCjzLdC18JgA+fNo16712wVCBjMY
         noQDubvl1d4IGXm5hBWd2k8MKlQRMUgVyctakaSE6YKpZulQdDf8RvWRO3JJqEe1/FXa
         05Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K0UTNyFjnWAm81T+6T7MV8PAIP8Ov1M1CXNQN9e1iUc=;
        b=clJrqcnomNG2LkmsreBnq4vpA24dpdqXHKyp4bUenaKeN/6KNRgIwZiy3zyTaemzrP
         B/HTf66bItlDLNsZGx19NndblmodQhuiJvoY2ohn1GlLohfnH+F8C3/c8EX4Kk3vm1tX
         yw5mcvHENdPBmcnxzSZrEkSbeR0iJfqEeGSAh83UKLYIS48aHM1Gb4dVeF5TeQXPoaOz
         Wxud9MaaTuv3MZ8wdkISWpMDCGmKzTY+8twmwYowr3zexuNMiF/d04xFubXpPmbtQEHn
         P0D0vgwywUaFayPoF5GVDiCeFHw7GwwNuUiREzDJygqRlK+Rn+RaAC9njhyOqDVczbix
         cW3Q==
X-Gm-Message-State: AOAM532Q1/IPQ9mVdBlKShG0UBbnJlKJjROWgBAjQG/yJCDezPt3kfDc
        6dthNXW1hfeROVIqe8uLZaJl0A==
X-Google-Smtp-Source: ABdhPJymTTXQUTqy2dt8CYQTGEW8jES70s4rfCSz7AS8TxfIQE2W8SNty8E32J9+vy/z8OrjmsSdww==
X-Received: by 2002:a5d:6c6b:: with SMTP id r11mr26137083wrz.548.1642533989801;
        Tue, 18 Jan 2022 11:26:29 -0800 (PST)
Received: from gmail.com ([77.125.69.23])
        by smtp.gmail.com with ESMTPSA id j21sm3051024wms.14.2022.01.18.11.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 11:26:29 -0800 (PST)
Date:   Tue, 18 Jan 2022 21:26:27 +0200
From:   Dan Aloni <dan.aloni@vastdata.com>
To:     trondmy@kernel.org
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFS: Always provide aligned buffers to the RPC read
 layers
Message-ID: <20220118192627.tg4myc77nmbqm2np@gmail.com>
References: <20210827180056.610170-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827180056.610170-1-trondmy@kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 27, 2021 at 02:00:56PM -0400, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Instead of messing around with XDR padding in the RDMA layer, we should
> just give the RPC layer an aligned buffer. Try to avoid creating extra
> RPC calls by aligning to the smaller value of ALIGN(len, rsize) and
> PAGE_SIZE.

I've bisected this change to be the cause of xfstests generic/525
getting stuck when tested against a standard Linux NFS server. It was
stuck in a repeated request loop in kernel mode, and killable.

I posted a patch with a full explanation in a reply.

-- 
Dan Aloni
