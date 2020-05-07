Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAD01C8002
	for <lists+linux-nfs@lfdr.de>; Thu,  7 May 2020 04:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgEGCaT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 May 2020 22:30:19 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20452 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgEGCaT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 May 2020 22:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588818617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4aCqWBMBziHNy+MjaVUVtwobCrMh4q6zCgK3P6euZwM=;
        b=eOFb6jke16q4WzXZ1b4G27En8I+BAhIRj4cVnD7ZgOJ1M4ypP4B1JCfdPvh50kRBb0x51e
        hnpeZbn0NvW+JmRAqFUbq+6N95CyQ+OwbaMIdSnBv5EsoTSVa+WRfAcEhG2b5ILTEPnY6D
        r2SkO4x84x7NPzYc3gEN0V2awhEMVyw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-DYjIeoj6NbCHjMQhswiZiQ-1; Wed, 06 May 2020 22:30:15 -0400
X-MC-Unique: DYjIeoj6NbCHjMQhswiZiQ-1
Received: by mail-qt1-f199.google.com with SMTP id w12so4922935qto.19
        for <linux-nfs@vger.kernel.org>; Wed, 06 May 2020 19:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4aCqWBMBziHNy+MjaVUVtwobCrMh4q6zCgK3P6euZwM=;
        b=BzqHKLF673NEqCVOF55Tx+KR5MSz55GM2EpwiUBGQFP9wqStJw/uhKGGJyakzb4E6m
         /nMlRgHFTdV4LM8YOqv26ZPtQuoQpcwoK9KtAdw1iBGOM6ETB92UBWcZ6Eja07ZiX9nq
         Yd9iodFRSEYb9/bU+F7BbZIROkjgVe5QqzIBqrSIkt38QwKHmrR1tXRXjgtgERfYAGnn
         TkHrR4JUrWH/rZWjao0zl29jXI9N5C55S6nguPJVIHdPaTIAaq+ZhwNg+7mLgBy7seTh
         R2owLK6EwuBmruO4SHGQ+eJDgS3roA/v+GikWbbVNH5DIRrUVPH8ZUMg/Le6NXDDqnlb
         vhaQ==
X-Gm-Message-State: AGi0PuY/jH5drPVvgOeXroOZNhNht5H0jIjr5ukhaHYn/FqjyxJ/rxKx
        7mVAYMDKeFPb7jfs4AVj0Nn1ffTOj5OXedXQiLBZJjQHZA0fO7/NHlpxiyLmnbADRTQK17U+Nrt
        80cU/6y9g/CckcMcAhXK782M6OtXz38yvLFVi
X-Received: by 2002:ac8:893:: with SMTP id v19mr11774271qth.40.1588818615073;
        Wed, 06 May 2020 19:30:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypJqB0m/kPELfI/Hw720nKfpdJ3+wSB4wQohxPiVx7D9AMoZIRCladZkTOOBQnzjZ+tGDZYCKl6+CGW2yQp45Uo=
X-Received: by 2002:ac8:893:: with SMTP id v19mr11774261qth.40.1588818614776;
 Wed, 06 May 2020 19:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200501062230.19693-1-kdsouza@redhat.com> <20200507013203.GD21307@fieldses.org>
In-Reply-To: <20200507013203.GD21307@fieldses.org>
From:   Kenneth Dsouza <kdsouza@redhat.com>
Date:   Thu, 7 May 2020 08:00:02 +0530
Message-ID: <CAA_-hQ+BDLVgQpL16iHXseNB4x-gh1qOvgd32dZyk-FO+PyF4w@mail.gmail.com>
Subject: Re: [PATCH] nfsd4: Make "info" file json compatible.
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org, Bruce Fields <bfields@redhat.com>,
        Achilles Gaikwad <agaikwad@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks for the feedback Bruce.

On Thu, May 7, 2020 at 7:02 AM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Fri, May 01, 2020 at 11:52:30AM +0530, Kenneth D'souza wrote:
> > Currently the output returned by client_info_show() is not
> > pure json, fix it so user space can pass the file properly.
>
> Gah, I said JSON, but the promise was that these files would be YAML,
> which I believe is a superset of JSON.
>
> I'd prefer not to make major backwards-incompatible changes.
>
> --b.
>
> >
> > Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
> > Signed-off-by: Achilles Gaikwad <agaikwad@redhat.com>
> > ---
> >  fs/nfsd/nfs4state.c | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index c107caa56525..f2a14f95ffa6 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -2341,19 +2341,24 @@ static int client_info_show(struct seq_file *m, void *v)
> >       if (!clp)
> >               return -ENXIO;
> >       memcpy(&clid, &clp->cl_clientid, sizeof(clid));
> > -     seq_printf(m, "clientid: 0x%llx\n", clid);
> > -     seq_printf(m, "address: \"%pISpc\"\n", (struct sockaddr *)&clp->cl_addr);
> > -     seq_printf(m, "name: ");
> > +     seq_printf(m, "{\n");
> > +     seq_printf(m, "\t\"clientid\": \"0x%llx\",\n", clid);
> > +     seq_printf(m, "\t\"address\": \"%pISpc\",\n", (struct sockaddr *)&clp->cl_addr);
> > +     seq_printf(m, "\t\"name\": ");
> >       seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
> > -     seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
> > +     seq_printf(m, ", ");
> > +     seq_printf(m, "\n\t\"minor version\": %d,\n", clp->cl_minorversion);
> >       if (clp->cl_nii_domain.data) {
> > -             seq_printf(m, "Implementation domain: ");
> > +             seq_printf(m, "\t\"Implementation domain\": ");
> >               seq_quote_mem(m, clp->cl_nii_domain.data,
> >                                       clp->cl_nii_domain.len);
> > -             seq_printf(m, "\nImplementation name: ");
> > +             seq_printf(m, ", ");
> > +             seq_printf(m, "\n\t\"Implementation name\": ");
> >               seq_quote_mem(m, clp->cl_nii_name.data, clp->cl_nii_name.len);
> > -             seq_printf(m, "\nImplementation time: [%lld, %ld]\n",
> > +             seq_printf(m, ", ");
> > +             seq_printf(m, "\n\t\"Implementation time\": \"[%lld, %ld]\"\n",
> >                       clp->cl_nii_time.tv_sec, clp->cl_nii_time.tv_nsec);
> > +             seq_printf(m, "}\n");
> >       }
> >       drop_client(clp);
> >
> > --
> > 2.21.1
>

