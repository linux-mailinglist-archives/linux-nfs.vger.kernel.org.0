Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BE22C3470
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 00:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732548AbgKXXOW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 18:14:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732474AbgKXXOV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Nov 2020 18:14:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606259660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=shNo4Dj0Fp9LaVP6cQwXhUnAz3jbyKD2CsEZ5ts05cc=;
        b=URzJliTf8zFMUudRjtiQebsLRJF+XxgUNW2rdHdp6d4gsXsRYxD3jxwGol4V0pe/Z+m9ug
        qcd1RToXcdhuCmrMAzsdf/p8bnd5+GpJxfP8rwuekf+hN+z1HA+dUqbN/1OJiC+HCjyVQX
        wXaLhR+8i11BBnWm8GvfxrCeOsitqkI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-wIu_NmVuMlSQ3wkZX76LvA-1; Tue, 24 Nov 2020 18:14:17 -0500
X-MC-Unique: wIu_NmVuMlSQ3wkZX76LvA-1
Received: by mail-qv1-f72.google.com with SMTP id cu18so456578qvb.17
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 15:14:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=shNo4Dj0Fp9LaVP6cQwXhUnAz3jbyKD2CsEZ5ts05cc=;
        b=DflO1zQ6hzFOq2uTK40oayt2sh5rE8nGDvSnMYajJIzQZo7ItCSkdfDW1C26LeQGan
         M8rSgX2RVOOLkhhDGz+sPDZWcvj4AtVtk/1Jt/04EDdOncFB5FOKTulPAenv9WjtmuP/
         99Uq8qHHto9TVFMqNrdiIEWZk500b/SQ7i5hYuQB+wM2x3XcaEcmBZhwwmBTV3Xf2Uhu
         jHsi43zhyMXxeznFf9aWgfponjgGzvHLxhthqq4otIJVndb1o7LpGfgAYzO3/WQsOXIN
         qgB6SXO9r7siBlcNLGC+tsmEzWu+ZFcnZi6yHp19hIX9Nal4CYPxmEuxIjyp4MtAjNLC
         LLwA==
X-Gm-Message-State: AOAM532iCi5f2yidyuU6swg67kuLJnEqbG6jT9Uafe6r4jhoPM+yEYax
        4ugTehewzWouLeqKa48zBzlz/yegM7js5vDezqLRt1Rl7KNic1yWUwUaGOapur4Vt0Hw62rNWHj
        OJM5FAVVKHkEKzN+aje6n
X-Received: by 2002:ac8:75da:: with SMTP id z26mr533054qtq.36.1606259656592;
        Tue, 24 Nov 2020 15:14:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIjrs9OKvBDSyjCsdyu1HlMH8Y9XwY5/wY7WKSSowxq8lN0Py/E/ple4PZG5GFe+C2hGRvww==
X-Received: by 2002:ac8:75da:: with SMTP id z26mr533036qtq.36.1606259656347;
        Tue, 24 Nov 2020 15:14:16 -0800 (PST)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id r48sm684096qtr.21.2020.11.24.15.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 15:14:15 -0800 (PST)
Message-ID: <0cbeed0a0fa2352961966efdd7e62247b5cd7a7b.camel@redhat.com>
Subject: Re: NFSD merge candidate for v5.11
From:   Jeff Layton <jlayton@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Bruce Fields <bfields@redhat.com>
Date:   Tue, 24 Nov 2020 18:14:14 -0500
In-Reply-To: <48FA73BE-2D86-4A3F-91D5-C1086E228938@oracle.com>
References: <48FA73BE-2D86-4A3F-91D5-C1086E228938@oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2020-11-24 at 17:51 -0500, Chuck Lever wrote:
> Hi-
> 
> I've added my NFSv4 XDR decoder series and Bruce's iversion
> series to my "for next" topic branch to get some early
> testing exposure for these changes.
> 
> Bruce's series is based on 8/8 posted on November 20, with
> Jeff's review comments integrated. The NFSD XDR decoder
> patches are based on v4, posted yesterday afternoon with
> Bruce's review comments integrated.
> 
> The full branch is available here:
> 
>   git://git.linux-nfs.org/projects/cel/cel-2.6.git cel-next
> 
> or
> 
>   http://git.linux-nfs.org/?p=cel/cel-2.6.git;a=shortlog;h=refs/heads/cel-next
> 
> ...and is still open for changes or additional patches. This
> branch is pulled into linux-next regularly.
> 
> 

Minor nit in:

    http://git.linux-nfs.org/?p=cel/cel-2.6.git;a=commit;h=2513716015eba398378bf453d5d2dd46c63a3399

You added a generic_check_iversion prototype to fs.h.

Move that into iversion.h. I think it makes more sense there, and that
avoids the huge rebuild that occurs when fs.h changes.

Cheers!
-- 
Jeff Layton <jlayton@redhat.com>

