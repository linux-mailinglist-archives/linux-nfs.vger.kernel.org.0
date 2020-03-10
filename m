Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1125180281
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Mar 2020 16:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgCJPyC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Mar 2020 11:54:02 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33073 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgCJPyB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Mar 2020 11:54:01 -0400
Received: by mail-ot1-f68.google.com with SMTP id g15so7512490otr.0;
        Tue, 10 Mar 2020 08:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NRfrf9uwWwOzURVwboVTmqZ/Om3tFIulQBv9KnWA3aI=;
        b=jFOZN4y99y/PkgvvbFm9LZrZf/4i0NMBed8D+GEisSHZ4YR3+T6WwfbjZjD2jaheYu
         E4bmrjwXjzAp9TkB3ZCldH3rXxkK6xIDXsrI/srDYPJz/dTQ7/sP8ADec6UrPjrnwdh/
         vSGNCjqpRoPpbW3Wxt2cCOKpSJS+gcY5TqVKf/3BoNtMfw7F/lpYvIGeCmHyRDnzcswG
         VoKrn0ZYNrJoQty84RvIkHxkONoGv9d1HzcEjEn76gGIg8Mo8CpJgrxFmB8OkVQUCWpr
         BA8XKS5UP//iJIimJ0L3UY9/eBfR0N7SDNKpmKQW66+cpewnOyDYvK+/OWrVSxcvUOKI
         Y70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NRfrf9uwWwOzURVwboVTmqZ/Om3tFIulQBv9KnWA3aI=;
        b=rrQBvGBp9Jw9Qh0NVC82/az0pzqOlTcYhfHNrTOZdWc+FM0MTTTySytLB942L0UuwW
         A2jNltVwLRVROsy8mbSF2gRe8UCIQsRUgVCYM4F+2PDQxv8cPNz1WZt2+negSqwMyD7P
         2QtsUjCWKsEhpCjlRIAoHSNiBNfWnDV9ZJ8e+3/uP6qh/K+8/iiJcSHLrIiMqkowwYP6
         pWpOcJseHK2Oqh0UHtCLtUaeI7dSAhQKB9UTxbmoVMBfJ/CGy3vwge/VEKtEnhZHKDQT
         7bQdDp4MvGOjnQYIhZ4r8intJOms9FazoMOpe9TPMJeUMQV8bjitke62kO6alygAowDw
         tgVQ==
X-Gm-Message-State: ANhLgQ0jYGMzlGz/LzPUBY3wScxSDQ0vxYxWQgbO83K4D5S2bNwQQM0C
        RPQ6H22VUMsIvV9skfBzdMXMQqRTLYnoydrgI6E=
X-Google-Smtp-Source: ADFU+vvAg4YH2zACj/N9NIZy1q8I0xm8nqMlIVw3M06uhuNkURxQLZKDiDUKMr0MvPYufNosFnHdQMtnqp+jHLvq54w=
X-Received: by 2002:a9d:76c9:: with SMTP id p9mr17434886otl.135.1583855639245;
 Tue, 10 Mar 2020 08:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200303225837.1557210-1-smayhew@redhat.com>
In-Reply-To: <20200303225837.1557210-1-smayhew@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 10 Mar 2020 11:54:48 -0400
Message-ID: <CAEjxPJ4JJDSn+BEb_BD+Lffd9MbEt9Yr6AOyTk5m7FONcZSdLg@mail.gmail.com>
Subject: Re: [PATCH] NFS: Ensure security label is set for root inode
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        Richard Haines <richard_c_haines@btinternet.com>,
        bfields@fieldses.org, Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, linux-nfs@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 3, 2020 at 5:59 PM Scott Mayhew <smayhew@redhat.com> wrote:
>
> When using NFSv4.2, the security label for the root inode should be set
> via a call to nfs_setsecurity() during the mount process, otherwise the
> inode will appear as unlabeled for up to acdirmin seconds.  Currently
> the label for the root inode is allocated, retrieved, and freed entirely
> witin nfs4_proc_get_root().
>
> Add a field for the label to the nfs_fattr struct, and allocate & free
> the label in nfs_get_root(), where we also add a call to
> nfs_setsecurity().  Note that for the call to nfs_setsecurity() to
> succeed, it's necessary to also move the logic calling
> security_sb_{set,clone}_security() from nfs_get_tree_common() down into
> nfs_get_root()... otherwise the SBLABEL_MNT flag will not be set in the
> super_block's security flags and nfs_setsecurity() will silently fail.
>
> Reported-by: Richard Haines <richard_c_haines@btinternet.com>
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
Tested-by: Stephen Smalley <sds@tycho.nsa.gov>
