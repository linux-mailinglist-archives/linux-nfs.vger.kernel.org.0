Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56970A05C2
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 17:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfH1PKI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 11:10:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbfH1PKH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Aug 2019 11:10:07 -0400
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com [209.85.161.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B5A687630
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2019 15:10:07 +0000 (UTC)
Received: by mail-yw1-f69.google.com with SMTP id x20so16491ywg.23
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2019 08:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=uZXDkflP8wM0FOdnZjDP2O+SOlXT58+5crJC+JX6QZ0=;
        b=Xm/W+Tln+VwpOXefXNxaWGLAP64wPPvm8+AtMJH3DkBweDaZP7TmHB0VZ0eZVNEyGS
         nY4RZ1Mf+vbcf6uHhfWnQbBxPUIrg91r7xbWXwmeUojN+HNCEjdZHXEkqv0Y9g7b7Dfg
         YHQqiO0df1p9WziWrR5Mu9FZUgB6DPg2d5uAPUrsg7MG03sRLOPJqnrHQH55+zZE+nRw
         vYiomO0USWpC+js/IqFuYgc/10WN8LJ8u7WEPFUkVvlfD0FGJZI0Vl1q5htQ73ZnzSY7
         6unHL/uePP429HybuILw2GCaa3Bs2/x4IriFUS7IyhKNYf/PtXlWIvux/wnH++NFG8F8
         rjvQ==
X-Gm-Message-State: APjAAAVp79bo1UZiFCBOH1fInwbyTlzlRFA6verSvGoegLrbVbxfh78Z
        2DjPWffW0zH5DuhEgOx08MzT4cfcsnhDc0LdEk/rhIEVzqWZRQop7AzPFsGLQbkDs1l3OsML0jB
        uwoO1o1F7Oo24BaQaVp+b
X-Received: by 2002:a5b:1c8:: with SMTP id f8mr3351844ybp.410.1567005007010;
        Wed, 28 Aug 2019 08:10:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzCL+4OZq6jgcAouHKR46nITo9aT0mJI9tnZUM7W2FMhN/pIaLHJgu4lnHfj3bRkn2rSuhuGA==
X-Received: by 2002:a5b:1c8:: with SMTP id f8mr3351821ybp.410.1567005006651;
        Wed, 28 Aug 2019 08:10:06 -0700 (PDT)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id d15sm549608ywa.34.2019.08.28.08.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 08:10:06 -0700 (PDT)
Message-ID: <5518fe8918715b3d1ed4547be66c3694408e9d37.camel@redhat.com>
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
From:   Jeff Layton <jlayton@redhat.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 28 Aug 2019 11:09:59 -0400
In-Reply-To: <20190828144031.GB14249@parsley.fieldses.org>
References: <ec7a06f8e74867e65c26580e8504e2879f4cd595.camel@hammerspace.com>
         <20190827145819.GB9804@fieldses.org> <20190827145912.GC9804@fieldses.org>
         <1ee75165d548b336f5724b6d655aa2545b9270c3.camel@hammerspace.com>
         <20190828134839.GA26492@fieldses.org>
         <ed2a86da204cbf644ef2dada4bda2b899da48764.camel@redhat.com>
         <45582F32-69C7-4DC8-A608-E45038A44D42@oracle.com>
         <20190828140044.GA14249@parsley.fieldses.org>
         <990B7B57-53B8-4ECB-A08B-1AFD2FCE13A6@oracle.com>
         <31658faabfbe3b4c2925bd899e264adf501fbc75.camel@redhat.com>
         <20190828144031.GB14249@parsley.fieldses.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2019-08-28 at 10:40 -0400, J. Bruce Fields wrote:
> On Wed, Aug 28, 2019 at 10:16:09AM -0400, Jeff Layton wrote:
> > For the most part, these sorts of errors tend to be rare. If it turns
> > out to be a problem we could consider moving the verifier into
> > svc_export or something?
> 
> As Trond says, this isn't really a server implementation issue, it's a
> protocol issue.  If a client detects when to resend writes by storing a
> single verifier per server, then returning different verifiers from
> writes to different exports will have it resending every time it writes
> to one export then another.
> 

Huh. I've always considered the verifier to be a per-inode quantity that
we just happened to fill with a global value, but the spec _is_ a bit
vague in this regard.

I think modern Linux clients track this on a per-inode basis, but I'm
not sure about really old Linux or other clients. It'd be good to know
about BSD and Solaris, in particular.
-- 
Jeff Layton <jlayton@redhat.com>

