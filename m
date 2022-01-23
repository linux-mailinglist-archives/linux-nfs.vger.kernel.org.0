Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0D1497060
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jan 2022 07:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiAWG3Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jan 2022 01:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiAWG3Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jan 2022 01:29:24 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026BAC06173B
        for <linux-nfs@vger.kernel.org>; Sat, 22 Jan 2022 22:29:24 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v6so7614745wra.8
        for <linux-nfs@vger.kernel.org>; Sat, 22 Jan 2022 22:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dzw69EPYwlmOHBt/UTItvtkhgc1C8duOChzsUdPkLrM=;
        b=OfDjgQvMjD4rGBeOelLMOt8qRNEevVS/WyAGxGUENlO1KhQXq3d/YfB06oIhMFKaj7
         suXkxFKBqBK46RskbQ++M+WX/GfyiJ4QzvPyH9ZdcqtuzB8Vu/1js6PM3oYun8UlN+s4
         MGdlLyfzT8vEtV9GNIE1FfTRKKNcN+m/KeUudiWC2d0cT8dPyjGHhzTPuDk67O2noywR
         AWBjwTJKCsOXzs/+9r1P9NQH1qV+fwhDUu+SVfrt4XQRRd93YfHXQM4wxFR1qC+lqYVu
         h1zBjEmw0wLvGeWd8RPa8zd+mfFHZCrvwltzBfvPW/i2nVL7gPJuW5S6cSyQcwoB0Qzv
         hzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dzw69EPYwlmOHBt/UTItvtkhgc1C8duOChzsUdPkLrM=;
        b=LM37449XDOT+2Zp/4BCf+VWt9eokrMZvKDdGXRVsu951bvAQ/bfPU7DGac1ufFQqmP
         b2uwM1za79RMJnBApIXZOv6pzbd0rP/tY9PluM5+Hy0tL0+1uxPYqvDfVPz5CZm9hajx
         8UGiUvNL+XfWv8G36HrDkvYvVTc4I4bOCnUlLLr360ZA5ot0CVeRlenm1UImZl1C7ow7
         3ZemZ3IU8nF25EODUpJorzzyIdeJ7X0DdCERTFHyHfO62khU+qgEVSqehC6hKSl63uH8
         hw6BzW4khvt/WwUxXGiKxah5Zc47axf0+RPQYLhCuiZ7DHX3KEfTy+b8g9ajKoXCgXBs
         JvQw==
X-Gm-Message-State: AOAM5319MgtgV5o9H5C0RwLO7Nal6vzXggHGMnc6XWO7JYZqyRShC73k
        EGU6hUypGIp0SXdCZT10t6JDDB6j7bnkCQ==
X-Google-Smtp-Source: ABdhPJxysGC4y0/6b+oIc8pL9PUBcBBxd5BKomrQJg3ie53c03T32/ggPJVqrziurP7zr+9gIL5S9g==
X-Received: by 2002:adf:fec7:: with SMTP id q7mr9499201wrs.85.1642919362608;
        Sat, 22 Jan 2022 22:29:22 -0800 (PST)
Received: from gmail.com ([2a0d:6fc2:4951:4400:aa5e:45ff:fee1:90a8])
        by smtp.gmail.com with ESMTPSA id p4sm15145353wmq.40.2022.01.22.22.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 22:29:22 -0800 (PST)
Date:   Sun, 23 Jan 2022 08:29:19 +0200
From:   Dan Aloni <dan.aloni@vastdata.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFSD: trim reads past NFS_OFFSET_MAX and fix NFSv3
 check
Message-ID: <20220123062919.7yjz5ryousix6vxf@gmail.com>
References: <5DD3C5DF-52EF-4C84-894C-FCBB9A0F4259@oracle.com>
 <20220122124953.1606281-1-dan.aloni@vastdata.com>
 <ADEC85C2-8D72-4E25-A49B-2039C1FF82F2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ADEC85C2-8D72-4E25-A49B-2039C1FF82F2@oracle.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Jan 22, 2022 at 05:37:16PM +0000, Chuck Lever III wrote:
> Similar language in RFC 8881 section 18.22.4:
> 
> >>    If the server returns a "short read" (i.e., fewer data than requested
> >>    and eof is set to FALSE), the client should send another READ to get
> >>    the remaining data.  A server may return less data than requested
> >>    under several circumstances.  The file may have been truncated by
> >>    another client or perhaps on the server itself, changing the file
> >>    size from what the requesting client believes to be the case.  This
> >>    would reduce the actual amount of data available to the client.  It
> >>    is possible that the server reduce the transfer size and so return a
> >>    short read result.  Server resource exhaustion may also occur in a
> >>    short read.
> 
> So the server could be returning INVAL and leaving EOF set
> to false. That might be triggering the client to retry the
> READ. Does the server need to set the EOF flag if the READ
> arguments cross the limit of the range that the server can
> return? Does the client need to check for this case and
> stop retrying? The specs aren't particularly clear on this
> matter.

But eof only in `resok` and not in `resfail`. For reference, here's the
reply I got:

Network File System, READ Reply  Error: NFS3ERR_INVAL
    [Program Version: 3]
    [V3 Procedure: READ (6)]
    Status: NFS3ERR_INVAL (22)
    file_attributes  Regular File mode: 0600 uid: 0 gid: 0
        attributes_follow: value follows (1)
        attributes  Regular File mode: 0600 uid: 0 gid: 0
            Type: Regular File (1)
            Mode: 0600, S_IRUSR, S_IWUSR
            nlink: 1
            uid: 0
            gid: 0
            size: 9223372036854775807
            used: 4096
            rdev: 0,0
            fsid: 0x0000000000000002 (2)
            fileid: 69
            atime: Jan 18, 2022 20:20:33.611267439 IST
                seconds: 1642530033
                nano seconds: 611267439
            mtime: Jan 18, 2022 20:20:33.571266608 IST
                seconds: 1642530033
                nano seconds: 571266608
            ctime: Jan 18, 2022 20:20:33.571266608 IST
                seconds: 1642530033
                nano seconds: 571266608

-- 
Dan Aloni
