Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5123747B2D4
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Dec 2021 19:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhLTS1t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Dec 2021 13:27:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233685AbhLTS1t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Dec 2021 13:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640024868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Eo3PKtw1L761aiISGa6jWzJcqIXJLNEgiul4itzHnM=;
        b=gDtFMDyjmk7di16/nZ9bwXMFY6Pe0Y+RKgd9cVE0mV3TNnpFGMOOuE8Qx9vPX83dL6d1zk
        RX2mBKQuZSz01DXebwRcjwibt/HyLMJrLbanhgPv1uqsLPNgcqDpSyyVSCaF8nx7X5KGdQ
        TfqSN8Vj1M4etoVKnO97+UFEVQIX3fU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-WI40orooN0CuOrjwzQKWBw-1; Mon, 20 Dec 2021 13:27:46 -0500
X-MC-Unique: WI40orooN0CuOrjwzQKWBw-1
Received: by mail-ed1-f71.google.com with SMTP id z8-20020a056402274800b003f8580bfb99so2886106edd.11
        for <linux-nfs@vger.kernel.org>; Mon, 20 Dec 2021 10:27:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Eo3PKtw1L761aiISGa6jWzJcqIXJLNEgiul4itzHnM=;
        b=HIuBQEOHT3tpvt6niLGYO95eX+9HiaOouXaiP3LOjYn1ZYfKWuRkrbEsTmSPmdfe8T
         xTjCjuVYYBiJ6G7iD2gS8VMEQb4QG8wg0N+x8zMdoi6RYB+EI6dGgEgB6bDPjZcrJ7Pv
         tBJu0vKWwMtGMQuZ5IqhoB3KWvDqp5KUaj5QEjdBcsOTXDb7ovHMEkywur1J4YoBBNvI
         apv7MFOJZqglSDdME1ny9jV6zapFPM7nQUgCwur3wDVde+N4r3kbzFiW/egRvVWgqFoV
         ypKu1C5B0LVloDz7TZZ49wY8/DAl7nkIl57vwAEB+q0rIJDdRtquSrwX6o/dHCVs9VA7
         46fw==
X-Gm-Message-State: AOAM531039QDaD8TZ3TJj1OdxjghfSCuyNuzjv/vovV2/c1bKCocYfdH
        F/TmKrzp+Kiv8XI4OF3KqIMaO9hhcrhiDnj/qIjvflwMioFEul6n7MM1ZFuHpyoy9buSfJqi0Za
        UO85ByvmkdsFOE8qxwlntVQ6DzgsIvtXveVc6
X-Received: by 2002:a17:907:d0b:: with SMTP id gn11mr2941564ejc.379.1640024865091;
        Mon, 20 Dec 2021 10:27:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsb7294ZUyIi9Ku5TPRgq/C5Xg9zgKzsM3DjhBoNTNnq5uCNEf+0Wayg03IyqowxVtm4R3bnrYvm1EQxblzk8=
X-Received: by 2002:a17:907:d0b:: with SMTP id gn11mr2941555ejc.379.1640024864936;
 Mon, 20 Dec 2021 10:27:44 -0800 (PST)
MIME-Version: 1.0
References: <1639763665-4917-1-git-send-email-dwysocha@redhat.com>
 <1639763665-4917-3-git-send-email-dwysocha@redhat.com> <2512433.1640021388@warthog.procyon.org.uk>
In-Reply-To: <2512433.1640021388@warthog.procyon.org.uk>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 20 Dec 2021 13:27:08 -0500
Message-ID: <CALF+zOnx8iAoOrOdmYZOaVB--EdfD8-ijM3iT0w4F+kn4p7rSw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] NFS: Rename fscache read and write pages functions
To:     David Howells <dhowells@redhat.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Dec 20, 2021 at 12:30 PM David Howells <dhowells@redhat.com> wrote:
>
> Dave Wysochanski <dwysocha@redhat.com> wrote:
>
> > Rename NFS fscache functions in a more consistent fashion
> > to better reflect when we read from and write to fscache.
>
> Do you want me to merge this into my patch that rewrites the nfs cache I/O?
>

Yes, I think it makes sense to merge this patch with the following
patch from your series:
[PATCH v3 64/68] nfs: Implement cache I/O by accessing the cache directly

