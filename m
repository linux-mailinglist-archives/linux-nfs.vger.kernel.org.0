Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1809B48951C
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jan 2022 10:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242733AbiAJJW0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jan 2022 04:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242820AbiAJJWW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jan 2022 04:22:22 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151E6C06173F
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jan 2022 01:22:22 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 30so49269306edv.3
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jan 2022 01:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eauTIQ2CXhE1KONg082Gs3Oe+Lf5gZxKgZdAKeBYLYs=;
        b=dkoFZBqXnAAGoEWby7bYV5+5ULXI4SPHabaK9/OkP1BBcHe+tU1hgU9jEubQbnGa68
         BzZTGrLu1jT/13pKT3FwBYTooNogFUG2kaj1cKX9kN3j6/zIhzh99eH+TI8WlO2DrXjw
         pKMEi99RKqL8xXYht/dIpu38n0425XZW9l1yD8nVQ25A3ohqJEBTc0DfwtQLAoIZqyEA
         J/GdyRbFQRoGPCcr3Usi255CvEqUeZqf8ZkC/fHRpQPCgrrsDRY0YFfBrxecey8VXLjg
         n0HdltoHZxWnGWT+JVwuO2uIgPMBWKGxQF7OIeIjI78CX4TzgXKBov4oBer9t+d3fxK2
         34/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eauTIQ2CXhE1KONg082Gs3Oe+Lf5gZxKgZdAKeBYLYs=;
        b=zxxcRtQHqoMs/b232sacSSpttZv4oqMLmoZg2VtT/zsSUj5nHGBxrKRG23Ic4upXnu
         JmrQUrLTDZoeK+7OphmHJ0LEPG25mhQzPqGc+Gu1FDXlRqhrjtP3CO8k/zq4dxx/NLTy
         T54jNGmPwj6zTUA59ISAr/S38QltrsCLfV+ftXmHy1oal9xMTu67+dyoyxOcGDMj6CGo
         ObfmzuYgS1HzxPF4CEHSo80cVyrH0v+ae7HsF8w7Uvyb3lYZWInV7z5MIYQzWENxwr0m
         Fq6XwBREAKbmeJZaCXApxVmEAVqcF47y3wg5nT88/pR5xJyzFLTfLn65w/z5UtNpYBMo
         fXAQ==
X-Gm-Message-State: AOAM533H9XQctJ9bWxWz+AnMQ9M4M4VaYJQJ6a/ktcn5H8gr26B7P65D
        iEXGSGDo5MieKGRZbQT5HUqWkSDTSY+8LlBHW2EOoVyqW8qYB5wb
X-Google-Smtp-Source: ABdhPJzGt7e5/LNWVgdQH6uuqNsS3ie/83p6gLuoy0Cm88hnp04VekgwTurXzbtKpENqF18YF5B6OY6jZ+IgS2KXf40=
X-Received: by 2002:a05:6402:5194:: with SMTP id q20mr1001687edd.113.1641806540388;
 Mon, 10 Jan 2022 01:22:20 -0800 (PST)
MIME-Version: 1.0
References: <CAPt2mGNF=iZkXGa93yjKQG5EsvUucun1TMhN5zM-6Gp07Bni2g@mail.gmail.com>
 <20220107171755.GD26961@fieldses.org>
In-Reply-To: <20220107171755.GD26961@fieldses.org>
From:   Daire Byrne <daire@dneg.com>
Date:   Mon, 10 Jan 2022 09:21:44 +0000
Message-ID: <CAPt2mGPtxNzigMEYXKFX0ayVc__gyJcQJVHU51CKqU+ujqh7Cg@mail.gmail.com>
Subject: Re: nconnect & repeating BIND_CONN_TO_SESSION?
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 7 Jan 2022 at 17:17, J. Bruce Fields <bfields@fieldses.org> wrote:
>
> Hm, doesn't each of these use up a reserved port on the client by
> default?  I forget the details of that.  Does "noresvport" help?

Yes, I think this might be the issue. It seems like only 13/16
connections actually initially get setup at mount time and then it
tries to connect the full 16 once some activity to the mountpoint
starts. My guess is that we run out of reserved ports at that point
and continually trigger the BIND_CONN_TO_SESSION.

I can use noresvport with an NFSv3 client mount and it seems to do the
right thing (with the server exporting "insecure), but it doesn't seem
to have any effect on a NFSv4.2 mount (still uses ports <1024). Is
that expected? Perhaps NFSv4.2 doesn't allow "insecure" mounts?

Daire
