Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70B4342F9E
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2019 21:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfFLTLl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jun 2019 15:11:41 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34778 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfFLTLk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Jun 2019 15:11:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id m29so19746685qtu.1
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2019 12:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zCNL4D6m3dTHA7BiGkQ5ouIyeWDrjEJa3TvbE5sI89Y=;
        b=mP5YzLEflWiTp355ixfDwfyF5e2cLSE1K1iicIZzwqjLpSWcR3zmAplGCqZoBWhbHV
         qgzfvufNE04iG7Ej4yuKsbPxrfAez/M9MWGVyXrJsNUJepVE/ryFrcevHZCcdt22E10e
         +gvskkSc1auhvRyQZXewygV7iDnUpbRkAXUS6ogbAQsGe3duw0Rr3NDqtMYkTe+MQVzq
         oxhb7C6C5NwAekVQYXRN7oguFXbFwkNlctqpVfPy9YoZfFM4woNhWc2C9GKk/4rNxxz/
         NEZP5jZmEIeyITBcJwNPFoWoOt11SPuPu9VWtOOQ10s6Xth/eGZyNpRY+yMboerK/QBr
         +Ijg==
X-Gm-Message-State: APjAAAWQkQpRDRXqJZddHpcTE8Ub/tI/Odxy3m1LNnp8zDM+FdrwQd4+
        xgOh8YjXxKRjaVjU6IgHV5Sh6bQ47r4=
X-Google-Smtp-Source: APXvYqxhftwTjK15dy78Mm6cn3cmJt/xGoSE5HoaHYY7OUqj64G3k7Rx9BA54IW0NyigN2DQZR/Kjw==
X-Received: by 2002:a0c:b902:: with SMTP id u2mr210866qvf.151.1560366699902;
        Wed, 12 Jun 2019 12:11:39 -0700 (PDT)
Received: from dhcp-12-212-173.gsslab.rdu.redhat.com (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id r40sm379173qtr.57.2019.06.12.12.11.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 12:11:38 -0700 (PDT)
Message-ID: <829626a0e3e51cd58048f5ef02a846cae4fe5b63.camel@redhat.com>
Subject: Re: [PATCH] NFSv4: Add lease_time and lease_expired to 'nfs4:' line
 of mountstats
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 12 Jun 2019 15:11:37 -0400
In-Reply-To: <230AB123-B417-4F6F-A50C-053B9B3E0C19@oracle.com>
References: <1558127201-7481-1-git-send-email-dwysocha@redhat.com>
         <230AB123-B417-4F6F-A50C-053B9B3E0C19@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2019-05-20 at 11:10 -0400, Chuck Lever wrote:
> > On May 17, 2019, at 5:06 PM, Dave Wysochanski <dwysocha@redhat.com>
> > wrote:
> > 
> > On the NFS client there is no low-impact way to determine the nfs4
> > lease time or whether the lease is expired, so add these to
> > mountstats
> > with times displayed in seconds.
> > 
> > If the lease is not expired, display lease_expired=0. Otherwise,
> > display lease_expired=seconds_since_expired, similar to 'age:' line
> > in mountstats.
> > 
> > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > ---
> > fs/nfs/super.c | 11 +++++++++++
> > 1 file changed, 11 insertions(+)
> > 
> > diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> > index c27ac96..6e52f0c 100644
> > --- a/fs/nfs/super.c
> > +++ b/fs/nfs/super.c
> > @@ -730,6 +730,16 @@ int nfs_show_options(struct seq_file *m,
> > struct dentry *root)
> > EXPORT_SYMBOL_GPL(nfs_show_options);
> > 
> > #if IS_ENABLED(CONFIG_NFS_V4)
> > +static void show_lease(struct seq_file *m, struct nfs_server
> > *server)
> > +{
> > +	struct nfs_client *clp = server->nfs_client;
> > +	unsigned long expire;
> > +
> > +	seq_printf(m, ",lease_time=%ld", clp->cl_lease_time / HZ);
> > +	expire = clp->cl_last_renewal + clp->cl_lease_time;
> > +	seq_printf(m, ",lease_expired=%ld",
> > +		   time_after(expire, jiffies) ?  0 : (jiffies -
> > expire) / HZ);
> > +}
> > #ifdef CONFIG_NFS_V4_1
> > static void show_sessions(struct seq_file *m, struct nfs_server
> > *server)
> > {
> > @@ -838,6 +848,7 @@ int nfs_show_stats(struct seq_file *m, struct
> > dentry *root)
> > 		seq_printf(m, ",acl=0x%x", nfss->acl_bitmask);
> > 		show_sessions(m, nfss);
> > 		show_pnfs(m, nfss);
> > +		show_lease(m, nfss);
> > 	}
> > #endif
> > 
> > -- 
> > 1.8.3.1
> > 
> 
> I didn't look closely at the patch content, but IMO this is a good
> observability enhancement.
> 
> 
> 

Thanks Chuck.  Trond or Anna do you have any concerns about this patch?

I didn't bump NFS_IOSTAT_VERS as I understand that only covers the
counts not the other lines in nfs_show_stats, correct?

Thanks.



