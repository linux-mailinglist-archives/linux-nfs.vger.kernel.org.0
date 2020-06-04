Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E6C1EEA96
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2020 20:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgFDSxQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Jun 2020 14:53:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49586 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728476AbgFDSxQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Jun 2020 14:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591296795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aekG9mWmr6Bu9/zhemMbV6tEy9wacArwZKVmcDVcPxI=;
        b=c6tzGrcx8F/J2+SRM046L/s81Q09WK3jXGGlJub2n/bIvAU+uCdTzdTQtbGABTdXVXhZr0
        Od8xZHPxjbs+ihBAHer2kDeLUNpuzG8l9xZamEcwH4BLipKdsRHRpRd47MQE6k+rVlyRSy
        7pq2Ti3J/+bQWmrKj343QewzDqoixg0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-acFC1U7rNWiXdjNsqWp71g-1; Thu, 04 Jun 2020 14:53:13 -0400
X-MC-Unique: acFC1U7rNWiXdjNsqWp71g-1
Received: by mail-qk1-f199.google.com with SMTP id a6so5477081qka.9
        for <linux-nfs@vger.kernel.org>; Thu, 04 Jun 2020 11:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aekG9mWmr6Bu9/zhemMbV6tEy9wacArwZKVmcDVcPxI=;
        b=ZrqYsh1Hc+KlCKwfeLDxSilV4vHyJKqKiyQdNDXqNLj19Zj4yrWL6RHNCDLjr8UdRK
         2xd4td3wjOIYGTrJAvRD37UZYIGewydRNCSGMXjEVVP31puEB1tFlMGki7lUIlLzSswR
         bkbZU8aFcLlMIol6M8tILdBjZXFsm6FDd/O3yUccTslapb/T1kOATn4bpOvp6RTl6T/q
         I9qvHt385bhmbTTiBijtQQtzlBDqZooD7Q5f7bgn+vCC082edTnOXcQTYux9tUxv2dnH
         PMzuyRsjE1yyJSCSI/XaeqQTszWVtLeTJSHMyBCaMLEfXDKoE3Afy8/Pg9fPnTw3bBq2
         Zrvg==
X-Gm-Message-State: AOAM531sDYcfT9zpfvzFDbgc5elFw9/biTDQNnGPOJh+JZnLRvzBqHqo
        4KW8742wvbCSk/+flOF2lltq44OtJEHfJ41DVEjDZnwxp80EprVXxw2TBA/UIq0i77iX9HnqGMR
        6GAKaIdXAPIz1hiKIg86ueYS/9+8ID9nfZrjp
X-Received: by 2002:a0c:fde4:: with SMTP id m4mr6135243qvu.207.1591296793145;
        Thu, 04 Jun 2020 11:53:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxCQCw7rgqjv0v+gHW+er7/KSW2wVYPjMRaC1EjiipUgc6cFMz9V0+vz0uBshOsEU4WTbZub077NEl5y41ITQ=
X-Received: by 2002:a0c:fde4:: with SMTP id m4mr6135223qvu.207.1591296792794;
 Thu, 04 Jun 2020 11:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175221.GA157967@fedora.rsable.com> <04942C45-9C31-424E-B5A1-C83553F786CE@oracle.com>
In-Reply-To: <04942C45-9C31-424E-B5A1-C83553F786CE@oracle.com>
From:   Kenneth Dsouza <kdsouza@redhat.com>
Date:   Fri, 5 Jun 2020 00:23:01 +0530
Message-ID: <CAA_-hQKa6X1pqCoLkUjB+ApNxjWE3OapgxcSCL-B1b=npFefGQ@mail.gmail.com>
Subject: Re: [PATCH v2] mountstats: Adding 'Day:Hour:Min:Sec' format along
 with 'age' to "mountstats --nfs" for ease of understanding.
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Rohan Sable <rsable@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>, smayhew@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Using the datetime module?

datetime.timedelta(seconds = n)
Should print in below format
0:11:05

On Thu, Jun 4, 2020 at 11:45 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jun 4, 2020, at 1:52 PM, Rohan Sable <rsable@redhat.com> wrote:
> >
> > This patch adds printing of 'Age' in 'Sec' and 'Day:Hours:Min:Sec' like below to --nfs in mountstats :
> > NFS mount age: 9479; 0 Day(s) 2 Hour(s) 37 Min(s) 59 Sec(s)
> >
> > Signed-off-by: Rohan Sable <rsable@redhat.com>
> > ---
> > tools/mountstats/mountstats.py | 12 ++++++++++++
> > 1 file changed, 12 insertions(+)
> >
> > diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
> > index d565385d..c4f4f9e6 100755
> > --- a/tools/mountstats/mountstats.py
> > +++ b/tools/mountstats/mountstats.py
> > @@ -233,6 +233,16 @@ Nfsv4ops = [
> >     'COPY_NOTIFY'
> > ]
> >
> > +# Function to convert sec from age to Day:Hours:Min:Sec.
> > +def sec_conv(rem):
> > +    day = int(rem / (24 * 3600))
> > +    rem %= (24 * 3600)
> > +    hrs = int(rem / 3600)
> > +    rem %= 3600
> > +    min = int(rem / 60)
> > +    sec = rem % 60
> > +    print(day, "Day(s)", hrs, "Hour(s)", min, "Min(s)", sec, "Sec(s)")
> > +
>
> Just wondering if there's a Python module that can do this for us?
>
>
> > class DeviceData:
> >     """DeviceData objects provide methods for parsing and displaying
> >     data for a single mount grabbed from /proc/self/mountstats
> > @@ -391,6 +401,8 @@ class DeviceData:
> >         """Pretty-print the NFS options
> >         """
> >         print('  NFS mount options: %s' % ','.join(self.__nfs_data['mountoptions']))
> > +        print('  NFS mount age: %d' % self.__nfs_data['age'], end="; ")
> > +        sec_conv(self.__nfs_data['age'])
> >         print('  NFS server capabilities: %s' % ','.join(self.__nfs_data['servercapabilities']))
> >         if 'nfsv4flags' in self.__nfs_data:
> >             print('  NFSv4 capability flags: %s' % ','.join(self.__nfs_data['nfsv4flags']))
> > --
> > 2.25.4
> >
>
> --
> Chuck Lever
>
>
>

