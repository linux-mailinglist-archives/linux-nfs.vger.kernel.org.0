Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD8A7145CC0
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2020 20:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgAVT4A (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Jan 2020 14:56:00 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:36691 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVT4A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Jan 2020 14:56:00 -0500
Received: by mail-wr1-f47.google.com with SMTP id z3so435810wru.3;
        Wed, 22 Jan 2020 11:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=ATXQxVfQbWJIgQw3/oEtTSU+qU+D47YRLOoi//94py4=;
        b=MuF7EqjBMQ0XogfEQUpg7R3avQdsPvV2ZWUxljYl1l2VyOrXumex84/84DQCajzMHM
         8TFimuACiPqBNgB6eQYmxW6beTcJ37ane7Y9AgQmMsJAzt9ulNK3Mb8pqAzAETNG8Bgp
         og1aFAvxCkx1XnxZlf7jRN91kNSEAyHZOKUIRq9TdxY3u59w1X2NCMGMuNksLktgdYnK
         e0ZOwmAXOq+Ql9juIcYCkfKsoDeK1y5NZP4q0tvtu41HhN3CCltI+ydcLdqDVRO3yqyp
         jSkdlibmsSkSZtI8CcLMUfpdGdDT+QO5R6DgCrsQfKlOHVy5wy9FU9mq+mLXuvYrSwbL
         tPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:content-language
         :thread-index;
        bh=ATXQxVfQbWJIgQw3/oEtTSU+qU+D47YRLOoi//94py4=;
        b=rlYIdkzGDRvQiwjoBHN5mI2NKpOEXk43+eVW2wWDPWF6WD7KUkWivV9eABHgZMXJIN
         jrMjA9HfUQ8xd92KM4xACbFWK56m9Y5mKCTMy6LWvlS5m3d4rA41aYjVRdNp0Cn1gdQA
         vimRIIDtuxNAXQq5QeTHvdJfO9N9N6aO4i1o5c/Yv8DgmSh2PpTkjjDDGzL8xlO+1ir4
         gSj6ByYtQ0nsuH8ZE1DoPi0IwbK6FbK+8owPLJhffmRF5N4plS/giVRhyycZpPuM5lqV
         qKMA2RihH5N/9R+fsY2ptuilFnY48J3q/YUKKjfZCWSIjqnTcI5w5OEkgGvrWa6ZPbSG
         q9Lg==
X-Gm-Message-State: APjAAAUJQ/cghhyG42GTasUA0j443aveiobbfaIWVBK8TKZmUDUnkNPl
        d4eAWovf8a58cde/LMyfHGel13Rk2Dz8bw==
X-Google-Smtp-Source: APXvYqxOlEeOMaZIf+53PwNJXSTonqAVv0oP6QDxngI0ciaN9F/jg66fFmjTQrXdX1Oi0ToeOy2KQA==
X-Received: by 2002:a5d:6ac2:: with SMTP id u2mr12317905wrw.233.1579722958365;
        Wed, 22 Jan 2020 11:55:58 -0800 (PST)
Received: from WINDOWSSS5SP16 ([82.31.89.128])
        by smtp.gmail.com with ESMTPSA id q3sm5226956wmj.38.2020.01.22.11.55.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jan 2020 11:55:57 -0800 (PST)
From:   "Robert Milkowski" <rmilkowski@gmail.com>
To:     "'Schumaker, Anna'" <Anna.Schumaker@netapp.com>,
        <chuck.lever@oracle.com>, <trondmy@hammerspace.com>
Cc:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <trond.myklebust@hammerspace.com>
References: <025801d5bf24$aa242100$fe6c6300$@gmail.com>  <D82A1590-FAA3-47C5-B198-937ED88EF71C@oracle.com>       <084f01d5cfba$bc5c4d10$3514e730$@gmail.com> <49e7b99bd1451a0dbb301915f655c73b3d9354df.camel@netapp.com>
In-Reply-To: <49e7b99bd1451a0dbb301915f655c73b3d9354df.camel@netapp.com>
Subject: RE: [PATCH v3] NFSv4.0: nfs4_do_fsinfo() should not do implicit lease renewals
Date:   Wed, 22 Jan 2020 19:55:57 -0000
Message-ID: <075401d5d15d$f6d0cb20$e4726160$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQFSV8btGYpaKSSrODVQVe6EyfKpewKNWQiWAfB5jHQAou/4BajVBKRQ
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> -----Original Message-----
> From: Schumaker, Anna <Anna.Schumaker@netapp.com>
> Sent: 22 January 2020 19:11
> To: rmilkowski@gmail.com; chuck.lever@oracle.com; trondmy@hammerspace.com
> Cc: linux-nfs@vger.kernel.org; linux-kernel@vger.kernel.org;
> trond.myklebust@hammerspace.com
> Subject: Re: [PATCH v3] NFSv4.0: nfs4_do_fsinfo() should not do implicit
> lease renewals
> 
> Hi Robert,
> 
> On Mon, 2020-01-20 at 17:55 +0000, Robert Milkowski wrote:
> > > -----Original Message-----
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > > Sent: 30 December 2019 15:37
> > > To: Robert Milkowski <rmilkowski@gmail.com>
> > > Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>; Trond
> > > Myklebust <trond.myklebust@hammerspace.com>; Anna Schumaker
> > > <anna.schumaker@netapp.com>; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH v3] NFSv4.0: nfs4_do_fsinfo() should not do
> > > implicit lease renewals
> > >
> > >
> > >
> > > > On Dec 30, 2019, at 10:20 AM, Robert Milkowski
> > > > <rmilkowski@gmail.com>
> > > wrote:
> > > > From: Robert Milkowski <rmilkowski@gmail.com>
> > > >
> > > > Currently, each time nfs4_do_fsinfo() is called it will do an
> > > > implicit
> > > > NFS4 lease renewal, which is not compliant with the NFS4
> > > specification.
> > > > This can result in a lease being expired by an NFS server.
> > > >
> > > > Commit 83ca7f5ab31f ("NFS: Avoid PUTROOTFH when managing leases")
> > > > introduced implicit client lease renewal in nfs4_do_fsinfo(),
> > > > which can result in the NFSv4.0 lease to expire on a server side,
> > > > and servers returning NFS4ERR_EXPIRED or NFS4ERR_STALE_CLIENTID.
> > > >
> > > > This can easily be reproduced by frequently unmounting a
> > > > sub-mount, then stat'ing it to get it mounted again, which will
> > > > delay or even completely prevent client from sending RENEW
> > > > operations if no other NFS operations are issued. Eventually nfs
> > > > server will expire client's lease and return an error on file access
> or next RENEW.
> > > >
> > > > This can also happen when a sub-mount is automatically unmounted
> > > > due to inactivity (after nfs_mountpoint_expiry_timeout), then it
> > > > is mounted again via stat(). This can result in a short window
> > > > during which client's lease will expire on a server but not on a
> client.
> > > > This specific case was observed on production systems.
> > > >
> > > > This patch makes an explicit lease renewal instead of an implicit
> > > > one, by adding RENEW to a compound operation issued by
> > > > nfs4_do_fsinfo(), similarly to NFSv4.1 which adds SEQUENCE
> operation.
> > > >
> > > > Fixes: 83ca7f5ab31f ("NFS: Avoid PUTROOTFH when managing leases")
> > > > Signed-off-by: Robert Milkowski <rmilkowski@gmail.com>
> > >
> > > Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> > >
> > >
> >
> > How do we progress it further?
> 
> Thanks for following up! I have the patch included in my linux-next branch
> for the next merge window.
> 
> Anna

Nice. Thanks!


-- 
Robert Milkowski


