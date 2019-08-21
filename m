Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0643897081
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2019 05:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfHUDsv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Aug 2019 23:48:51 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:42422 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfHUDsv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Aug 2019 23:48:51 -0400
Received: by mail-oi1-f169.google.com with SMTP id o6so555919oic.9
        for <linux-nfs@vger.kernel.org>; Tue, 20 Aug 2019 20:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DNeO2I5P7X1Lbvd2VIQqSVnNMPmHOfkiBxbwoy7aOis=;
        b=azVQoxxsK3C5RN9SSDKAjKCwrJ0JFXMJwQyItUs9Zy8d7o/ESF6YdgOmKmQLYJQfoM
         RKK84QFCZEtiDvhegDfz+K5VcCdHPfSJbbsrn/uYTzBivfivh2rnieZqD4+C6NFv8WuK
         hqEkJJmFhXlZJlacoTpIc1YMg7/eLH6ogRIy5nFBGMaYRTn9qKE3AlRE65skc7cy7R0Y
         R15phWfS3qXDepRKz7kscbeL3M4soYteIn3Ozk6sHIgMAUnPK010dtqpJgk0JDNtPaeS
         ahmjzFe/Ra1AERPQnu+ocANaEttZ1yfR+9uSmMnHrzq+8pMTxSM+qD8pUTdc4v2B+mvJ
         1Fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DNeO2I5P7X1Lbvd2VIQqSVnNMPmHOfkiBxbwoy7aOis=;
        b=HhNdXNaFVPp5iEN/KU5n2TVd+iWit/5Z/lmQtes2oQertQCMuZ13ZgdmgxMVHa5D1/
         FQXcuyBut2zg3LSvo2ROBWsMYkPHw6sULafxKGgtpC0LyMEBR/hU77UuBbVsJHX55iBn
         cTnJvQqt5X9Vit7BffDo2Qq16kzPGYpAFuL2rQK2G42FimZRuZ5OkgsSDYIpzcQ1nSrv
         IiTF/HIEt8Wx3tfW64u2sdk4/7PWTYbm1Jk34/XNksHz3dS1B7aah2IIS001bq5J7xG3
         erj9yufOKsBBFWe+QupTEVTSBTukKUTZGv/hwtMFKCIdpJFYNzPya3nGDvOOt9EfaEaY
         17QA==
X-Gm-Message-State: APjAAAWRoEtXrWgP6fZxUbNA5auVaca1aP3LRkjXvb2AoYBmR4gJBs9A
        TcTKrw2FfEuxBoSoJR9uEObCyzL1IuxXHvo3aZMSbA==
X-Google-Smtp-Source: APXvYqzAxxh0GTyz2p6TU6M3TxnFZxOT+XsgGtpQK1Nfz7TEWwmtVmKCu8mBDHODmhXoIT1MWpOrBWDCDod/7kCyI+k=
X-Received: by 2002:aca:d558:: with SMTP id m85mr2482178oig.0.1566359330468;
 Tue, 20 Aug 2019 20:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <72e41dc2-b4cf-a5dd-a365-d26ba1257ef9@oracle.com>
In-Reply-To: <72e41dc2-b4cf-a5dd-a365-d26ba1257ef9@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 20 Aug 2019 20:48:39 -0700
Message-ID: <CAPcyv4iPuTpk9bifyX5yQxO8gT0fRhYXPrwk-obazWA=Dou3iQ@mail.gmail.com>
Subject: Re: kernel panic in 5.3-rc5, nfsd_reply_cache_stats_show+0x11
To:     Jane Chu <jane.chu@oracle.com>
Cc:     CHUCK_LEVER <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 20, 2019 at 6:39 PM <jane.chu@oracle.com> wrote:
>
> Hi,
>
> Apology if there is a better channel reporting the issue, if so, please
> let me know.
>
> I just saw below regression in 5.3-rc5 kernel, but not in 5.2-rc7 or
> earlier kernels.

Is the error stable enough to bisect?
