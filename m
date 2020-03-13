Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4287184FE9
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2020 21:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgCMUIO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Mar 2020 16:08:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37041 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgCMUIO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Mar 2020 16:08:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id a141so11609568wme.2
        for <linux-nfs@vger.kernel.org>; Fri, 13 Mar 2020 13:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=iZS+FH53OkVhJcNSlkKU4D4ybFMgmQwg3DI7HcJdikE=;
        b=ZhepRq6vZdwutn6+dVvHa2Nd2fUg4bkpFCPnrioEPM8960wwQ6QNriSWhEvDJyluGZ
         HQ4DSXEFBc/Cc49UJZbZZ0+IKdIUweUfdMPsHzplzAiYXJCVtdUpATrIjywJPd2g8kUN
         +X8qvsCdKPUnDbUvGBlpgcYdfoxQRkH4mt8DlRYiMe3qVfCPkJ4YFaYW5XdWy0EYNkSw
         E3rqr3/a/UEm6Lg+97tyLpzT0wyZli0pYqhka4FZLhN4wiGKNSQkyh7rXnM+bLbRIk2F
         hqKd6uEOJoaBI3njBYrs7pVHS6K4oxJ/ZoHnCO+KQayTDEz+/LYp7RzpmGuQtLDAfnNj
         Lb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=iZS+FH53OkVhJcNSlkKU4D4ybFMgmQwg3DI7HcJdikE=;
        b=Mjg7lrt25OJ4WfCC4Vwd9TdDSr7kCgCotm18VPhvj5ewN7TD3eEdavykfbJVuQqKIh
         l9UkvxoIgzab1FuXgpEWe6Xt0hTL+6bC29z8cQkleU8deBMkKmDmN0aL2fh/iIsZJMLF
         5A8Py1hSREgwUzYanD7BexFmBti9L/N8GrET3YjZe0VX8+T9qeaz3fa1iuL5t/XSUSRS
         UEq6eSwmFxWnKLT2gvwnP6HOn1j7XtqCvz3uZA13dbKPY47LSewu7nEinDIZlbdRm9FF
         6FY5EqiBKPOrFYzRdkmrji7+8aJLUqXQWuf433V8iRYTnHYM4Ln7HijRP+WWsi37DmrY
         ZrQQ==
X-Gm-Message-State: ANhLgQ2Gim+2By+Y0Gj65+wce9nHy+UZMBk0u2JautVeR+VsfClipDEo
        gBVwjEptRNqhXs4ThJboq8zaEzga
X-Google-Smtp-Source: ADFU+vtr/jPNGO3gb2+d6KdtUIR0BSWbTZVZ7vFRqW98tXcFAM6FznTz4rZ4zqyJD/i08m+XNpiXBQ==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr12247146wmc.188.1584130090746;
        Fri, 13 Mar 2020 13:08:10 -0700 (PDT)
Received: from x230 ([62.201.25.198])
        by smtp.gmail.com with ESMTPSA id w4sm29801395wrl.12.2020.03.13.13.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 13:08:09 -0700 (PDT)
Date:   Fri, 13 Mar 2020 21:08:07 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Petr Vorel <pvorel@suse.cz>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>
Subject: Re: [PATCH 1/1] nfsd: remove read permission bit for ctl sysctl
Message-ID: <20200313200807.GA2137291@x230>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20200313123957.6122-1-pvorel@suse.cz>
 <5A8BA7E5-C24D-4FA6-9D4B-1216398CDF38@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A8BA7E5-C24D-4FA6-9D4B-1216398CDF38@oracle.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> Hi Petr, applied to nfsd-5.7-testing, with the patch description corrected
> to read:
> 
> "It's meant to be write-only."
Thanks, Chuck!

Kind regards,
Petr
