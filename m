Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C782143121
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Jan 2020 18:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgATRzF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Jan 2020 12:55:05 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:44381 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgATRzE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Jan 2020 12:55:04 -0500
Received: by mail-wr1-f51.google.com with SMTP id q10so355331wrm.11;
        Mon, 20 Jan 2020 09:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=O5uMg6n8WGJ3DBsT5DEpdZ6rnvvc2qRQxYALKuYYT+A=;
        b=Shm/O2tzG6ppkV1MKlYA5MYSsidRt5iztNG0N6I2Svc+1rC4msjb9YaWaYzpmuPvAU
         YlsTGL7oxYVZnlhCdX7jrWzcjusIgsV++ZOfUPYD0CH6BGamlgaiyNtWJbNJCQFGsZ6l
         Y4TFl0/5T891OwLnaHKPVWYDfL1glj4jkDZYfcXAeupnaSZAB3mHEIXVV0KtTVHU3nJW
         8JM+tzmklvYpGtdRmW1aQEqO2u0dNtekmNR1K+hjdfz+CCDwJ8fSAxWy0dNangOtBxsy
         kgReO03g5AoY+TuZBiMd0r7b1V+DAQ5pO7l/Jf0mRrluliYC5gL9nPw9Fv3hSAKNnZj6
         sV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=O5uMg6n8WGJ3DBsT5DEpdZ6rnvvc2qRQxYALKuYYT+A=;
        b=D9absaOm9Ee01SezQOByQ6wX7NKRLkmbnZ99RKoFAnrUw9LYWl7zZq7UdQEHu+COP/
         Bpt7k18OzwP+IL6CMZM3qrN1CXSCjz7uojEPMNkesxf9RCE/0oq9KL73/hIxxofU4rJ/
         8E692t7B8Fq1yl7YUL6OFAF862c3cBeDIxdaM3VPHjpWeXLVq8ToYVEHLduHkk0s4aOE
         3f2+aLl/JrplKIyudQGoq+EH/7ugZfXXvwJOxpY/BhDVQf7QoR5H+rI8t6meRI2cb8Mc
         0rd/SWG7O/5eZfHsNhOoMZMLcZeo2XCdvzQWHWPRfUsj0eHnNTUmEgB7Vl9c02dVPcIO
         fdLg==
X-Gm-Message-State: APjAAAWe/1aWIQs7j5UH5rju5KBvjOW8rVwO5RpcwScTmG7rdxPQTtuc
        syLPhlK+U9zNSnUW86yZSU9Zzr9apo8=
X-Google-Smtp-Source: APXvYqz7YXkQZ8dyRvLAFJO9vJHbPgvQyXxoKIByuPaAUfRMI2IYRQC4sHXqDvhH4AYunqNhrfKviw==
X-Received: by 2002:a5d:49cc:: with SMTP id t12mr668846wrs.363.1579542902577;
        Mon, 20 Jan 2020 09:55:02 -0800 (PST)
Received: from WINDOWSSS5SP16 ([82.31.89.128])
        by smtp.gmail.com with ESMTPSA id r15sm185321wmh.21.2020.01.20.09.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 09:55:02 -0800 (PST)
From:   "Robert Milkowski" <rmilkowski@gmail.com>
To:     "'Chuck Lever'" <chuck.lever@oracle.com>,
        "'Trond Myklebust'" <trondmy@hammerspace.com>
Cc:     "'Linux NFS Mailing List'" <linux-nfs@vger.kernel.org>,
        "'Trond Myklebust'" <trond.myklebust@hammerspace.com>,
        "'Anna Schumaker'" <anna.schumaker@netapp.com>,
        <linux-kernel@vger.kernel.org>
References: <025801d5bf24$aa242100$fe6c6300$@gmail.com> <D82A1590-FAA3-47C5-B198-937ED88EF71C@oracle.com>
In-Reply-To: <D82A1590-FAA3-47C5-B198-937ED88EF71C@oracle.com>
Subject: RE: [PATCH v3] NFSv4.0: nfs4_do_fsinfo() should not do implicit lease renewals
Date:   Mon, 20 Jan 2020 17:55:00 -0000
Message-ID: <084f01d5cfba$bc5c4d10$3514e730$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFSV8btGYpaKSSrODVQVe6EyfKpewKNWQiWqOZaxJA=
Content-Language: en-gb
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> -----Original Message-----
> From: Chuck Lever <chuck.lever@oracle.com>
> Sent: 30 December 2019 15:37
> To: Robert Milkowski <rmilkowski@gmail.com>
> Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>; Trond Myklebust
> <trond.myklebust@hammerspace.com>; Anna Schumaker
> <anna.schumaker@netapp.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3] NFSv4.0: nfs4_do_fsinfo() should not do implicit
> lease renewals
> 
> 
> 
> > On Dec 30, 2019, at 10:20 AM, Robert Milkowski <rmilkowski@gmail.com>
> wrote:
> >
> > From: Robert Milkowski <rmilkowski@gmail.com>
> >
> > Currently, each time nfs4_do_fsinfo() is called it will do an implicit
> > NFS4 lease renewal, which is not compliant with the NFS4
> specification.
> > This can result in a lease being expired by an NFS server.
> >
> > Commit 83ca7f5ab31f ("NFS: Avoid PUTROOTFH when managing leases")
> > introduced implicit client lease renewal in nfs4_do_fsinfo(), which
> > can result in the NFSv4.0 lease to expire on a server side, and
> > servers returning NFS4ERR_EXPIRED or NFS4ERR_STALE_CLIENTID.
> >
> > This can easily be reproduced by frequently unmounting a sub-mount,
> > then stat'ing it to get it mounted again, which will delay or even
> > completely prevent client from sending RENEW operations if no other
> > NFS operations are issued. Eventually nfs server will expire client's
> > lease and return an error on file access or next RENEW.
> >
> > This can also happen when a sub-mount is automatically unmounted due
> > to inactivity (after nfs_mountpoint_expiry_timeout), then it is
> > mounted again via stat(). This can result in a short window during
> > which client's lease will expire on a server but not on a client.
> > This specific case was observed on production systems.
> >
> > This patch makes an explicit lease renewal instead of an implicit one,
> > by adding RENEW to a compound operation issued by nfs4_do_fsinfo(),
> > similarly to NFSv4.1 which adds SEQUENCE operation.
> >
> > Fixes: 83ca7f5ab31f ("NFS: Avoid PUTROOTFH when managing leases")
> > Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
> 
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> 
> 

How do we progress it further?

-- 
Robert Milkowski



