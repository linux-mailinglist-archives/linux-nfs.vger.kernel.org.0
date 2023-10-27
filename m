Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05AC7D8ECE
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 08:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbjJ0Gfs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 02:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjJ0Gfr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 02:35:47 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA01B1B1;
        Thu, 26 Oct 2023 23:35:41 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66d12b3b479so11469886d6.1;
        Thu, 26 Oct 2023 23:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698388540; x=1698993340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fp6gDIEPkT1c2agrzuB5cI2sI1CdO/pgKBK73qZP9KQ=;
        b=b4JKBMrryn38HPhx1d6+BhIgkprPN2Ymzx91Em0KgZgeLQHODEds1oDAGlvmkxmUEc
         baEpaoXqMpXuxum5F0estmT1Lh6aQ8n/YDNYilo6oOZkdLjMIIoGyzra1fzL16lCXd00
         PZ4R0NjGiHzV4JItWYM5Xcef294x7FHVDY70bk7xpLzxgSwjeSOWvigj336Uk0AOWpKH
         SJV6VGGlxQpUCBRdmEpg4HefRt/1bctDeA7uQ9k160FPap95EXFMfQ30/5W9Z4s74tAp
         SrVHeNielJzFcPMO2aPM3Psxk3iQKq38ZeXPn+zU9KG8i9JPsh3TIEtv4fmysJPEAKG3
         rp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698388540; x=1698993340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fp6gDIEPkT1c2agrzuB5cI2sI1CdO/pgKBK73qZP9KQ=;
        b=S0QHFFQOz/gC+1TW69D7m405jH5HsApyICwmfSKxWuvm3TnC6wM1OUTsSqcHXr5C1I
         F4lRDtJ/e35mPnCqFqRdUQwu1+dLSief+AUuIjDHD+xfXYjGslVLZJqTh08larYzZrwA
         sAJ1Ag9DVM/XWEPx4wrmW/ar+UsMrFHa98az3sAH3VGKuzi0Onq0HWEOwAw6FFr/oSu3
         VNVfOHB3OdWZSQbi0hkpNSsFVG7KXiC08ePzd5EW4CZMLOnb/bENrSzDVsKOI5o//oMk
         9Pc+JvDHvFgumUs9p+MfQNiij0RKUmREy7aq8YfL8iC6WWEvhbFokj2ZLQ5aMkCZ6mn2
         AHzw==
X-Gm-Message-State: AOJu0Yy5Mp9B3gOf+ra3NBE1nQ9flclgCUqv+J7SYCJ0h3NCiQAHflRC
        ws4oFEVQB08bgTuqPTRx8Zfg49/ILDAtb88v6Ts=
X-Google-Smtp-Source: AGHT+IF+5aVowpk3bgckfPo9LPLCnT03FdTFKeJQiv4XSHZVuaR6PC++R4xLGV59lO40Bo+DAs3+Pc6HnuUeF9FcsIk=
X-Received: by 2002:a05:6214:f09:b0:66d:58a2:d23d with SMTP id
 gw9-20020a0562140f0900b0066d58a2d23dmr2490972qvb.61.1698388540580; Thu, 26
 Oct 2023 23:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231026205553.143556-1-amir73il@gmail.com> <ZTtT+8Hudc7HTSQt@infradead.org>
In-Reply-To: <ZTtT+8Hudc7HTSQt@infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 27 Oct 2023 09:35:29 +0300
Message-ID: <CAOQ4uxh+hWrMrP5A=fGRMK7uTxFFPKvJRNu+=Sc3ygXA1PzxvQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: create an entry for exportfs
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 27, 2023 at 9:08=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, Oct 26, 2023 at 11:55:53PM +0300, Amir Goldstein wrote:
> > Split the exportfs entry from the nfsd entry and add myself as reviewer=
.
>
> I think exportfs is by now very much VFS code.
>

Yes, that's the idea of making it a vfs sub-entry in MAINTAINERS.

Is that an ACK? or did you mean that something needs to change
in the patch?

Thanks,
Amir.
