Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A1D1EEB0E
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2020 21:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgFDTYE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Jun 2020 15:24:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29951 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728809AbgFDTYE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Jun 2020 15:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591298643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=06dxOM1CNZyATjH18daIyaDhwxk8nikiRnGliVkGu1o=;
        b=NBNv6Y1LqkMRT2bZbJ0jgmNMQOu0G0mmYUBxNISzB1FNx5F4OhEGsSnAZLnajg6rDvuocO
        2rggvbPUVDwTGQeX+FwI+8ujQoAXdYRkK2KW1rS8rRDLTjLAPy4n1qF1hAp+vM9K1T9HkJ
        7ZQBpPbXGBYDRW7E/zTv2EvEca+BIUM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-_eHidSURMISO5nLvXzNYHw-1; Thu, 04 Jun 2020 15:23:41 -0400
X-MC-Unique: _eHidSURMISO5nLvXzNYHw-1
Received: by mail-qt1-f200.google.com with SMTP id u26so6002262qtj.21
        for <linux-nfs@vger.kernel.org>; Thu, 04 Jun 2020 12:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=06dxOM1CNZyATjH18daIyaDhwxk8nikiRnGliVkGu1o=;
        b=chflSyUZTkbJBB4imikEFrj37QSUCWw8PNzEsxMp1Ka6xuZ/pEqGb+vQts8v3wsDrq
         PkQISBw2x4rTaoWm/ouuPB8j1dfQrtm/czwZeIYWroV6ljSxsXwjRpEPHW4X/YEQFBfe
         CT1uUPbtqugDDVK2vo+DPxaRjXHwmnF7ue6yjS4eqz+YmIcEnQLV0wjaTCCWVsc+dm1p
         fz1ZFW10lVqXlTioP/Y/qfgbPT2xJEmZWelPd9Ni/o3GlnIRrkGqQ5WEDYySOr6jSB0U
         cuIyvSqdirfqABb/MZs20gdusrmLFgEIHKnf9F9pSLIspksrwra32myMtUdzMW2jOC3S
         ElRw==
X-Gm-Message-State: AOAM532R5CQci7mnd+Y9TNtyzjeUsxLHsI7xQ9E6g/CkvIlhW4u0UG4Z
        ylPUaqG0R9qt/tEdYFp7IkrM+y8qCkSWR/9TXLbz3n3jXUQ1xKC1vsjCNUbuNy4mzvU/zfrj8TG
        PrS3YmKl1qOOfDn2jLbVIaLBj7wX7eVFPY4v7
X-Received: by 2002:ac8:1942:: with SMTP id g2mr6405215qtk.107.1591298620882;
        Thu, 04 Jun 2020 12:23:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+4oVtJOeOj53hdbowFHr+MPdPD0BqTyWMHG28/yLJkxvW0ctUr7dQqk7zy4EgRWQAeP3ufrgfFb0aXwM9qBs=
X-Received: by 2002:ac8:1942:: with SMTP id g2mr6405183qtk.107.1591298620517;
 Thu, 04 Jun 2020 12:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175221.GA157967@fedora.rsable.com> <04942C45-9C31-424E-B5A1-C83553F786CE@oracle.com>
 <CAA_-hQKa6X1pqCoLkUjB+ApNxjWE3OapgxcSCL-B1b=npFefGQ@mail.gmail.com>
In-Reply-To: <CAA_-hQKa6X1pqCoLkUjB+ApNxjWE3OapgxcSCL-B1b=npFefGQ@mail.gmail.com>
From:   Kenneth Dsouza <kdsouza@redhat.com>
Date:   Fri, 5 Jun 2020 00:53:29 +0530
Message-ID: <CAA_-hQLPDP208XriDoMBFEwnypPpEQJ_Tv5WSwDAbF_wW3fVFA@mail.gmail.com>
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

I get the below results using the datetime module.

# mountstats --nfs | grep -w age
  NFS mount age: 688865; 7 days, 23:21:05

On Fri, Jun 5, 2020 at 12:23 AM Kenneth Dsouza <kdsouza@redhat.com> wrote:
>
> Using the datetime module?
>
> datetime.timedelta(seconds = n)
> Should print in below format
> 0:11:05
>
> On Thu, Jun 4, 2020 at 11:45 PM Chuck Lever <chuck.lever@oracle.com> wrote:
> >
> >
> >
> > > On Jun 4, 2020, at 1:52 PM, Rohan Sable <rsable@redhat.com> wrote:
> > >
> > > This patch adds printing of 'Age' in 'Sec' and 'Day:Hours:Min:Sec' like below to --nfs in mountstats :
> > > NFS mount age: 9479; 0 Day(s) 2 Hour(s) 37 Min(s) 59 Sec(s)
> > >
> > > Signed-off-by: Rohan Sable <rsable@redhat.com>
> > > ---
> > > tools/mountstats/mountstats.py | 12 ++++++++++++
> > > 1 file changed, 12 insertions(+)
> > >
> > > diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
> > > index d565385d..c4f4f9e6 100755
> > > --- a/tools/mountstats/mountstats.py
> > > +++ b/tools/mountstats/mountstats.py
> > > @@ -233,6 +233,16 @@ Nfsv4ops = [
> > >     'COPY_NOTIFY'
> > > ]
> > >
> > > +# Function to convert sec from age to Day:Hours:Min:Sec.
> > > +def sec_conv(rem):
> > > +    day = int(rem / (24 * 3600))
> > > +    rem %= (24 * 3600)
> > > +    hrs = int(rem / 3600)
> > > +    rem %= 3600
> > > +    min = int(rem / 60)
> > > +    sec = rem % 60
> > > +    print(day, "Day(s)", hrs, "Hour(s)", min, "Min(s)", sec, "Sec(s)")
> > > +
> >
> > Just wondering if there's a Python module that can do this for us?
> >
> >
> > > class DeviceData:
> > >     """DeviceData objects provide methods for parsing and displaying
> > >     data for a single mount grabbed from /proc/self/mountstats
> > > @@ -391,6 +401,8 @@ class DeviceData:
> > >         """Pretty-print the NFS options
> > >         """
> > >         print('  NFS mount options: %s' % ','.join(self.__nfs_data['mountoptions']))
> > > +        print('  NFS mount age: %d' % self.__nfs_data['age'], end="; ")
> > > +        sec_conv(self.__nfs_data['age'])
> > >         print('  NFS server capabilities: %s' % ','.join(self.__nfs_data['servercapabilities']))
> > >         if 'nfsv4flags' in self.__nfs_data:
> > >             print('  NFSv4 capability flags: %s' % ','.join(self.__nfs_data['nfsv4flags']))
> > > --
> > > 2.25.4
> > >
> >
> > --
> > Chuck Lever
> >
> >
> >

