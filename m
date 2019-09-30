Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93CA9C23A1
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Sep 2019 16:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbfI3Ovc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Sep 2019 10:51:32 -0400
Received: from mail-yb1-f176.google.com ([209.85.219.176]:35666 "EHLO
        mail-yb1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731470AbfI3Ovc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Sep 2019 10:51:32 -0400
Received: by mail-yb1-f176.google.com with SMTP id f4so1195983ybm.2
        for <linux-nfs@vger.kernel.org>; Mon, 30 Sep 2019 07:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=p7PuTIiUkjbPozjs7v70iPmrVN6x8X3CAKBxJFLNrrI=;
        b=kAycoNmEVY9W/dtlZ4uemcKfMWi5Sn7qDt91JTDu9S3l7TUmqV687T+eblJIGdHS15
         L7sRL2q1QTyqh+KP6ONlCq5rAF7VWLuVZfi3+u6LmwtxbX6mqBA2mANApohuelwb7bNt
         iBal9rpUb06stGqjpv/rbQAsFyF9koFMEQgu+EaTMJBdIN/oo/TTLrkeCduTgnVx9WJc
         CxB7TmEI+CULkRkdtG/qq9vdVRkF2yPH9Edfis2YoxcoFN8Q/J38hUynABdXTpc5PaOd
         jhftjbG3KU0vIMWQWaPONgIOlqyVCnyeDCdl6uMpQKanejgPocWlsx7WFEehWUG6Nkd4
         bS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=p7PuTIiUkjbPozjs7v70iPmrVN6x8X3CAKBxJFLNrrI=;
        b=UIeVpX8NagGQnjWrvaQvVht41rQNkHhdzABMRWbQ2IfN20o32hRJYLuWz7xdu92Fnw
         jWTaPbFVWhX1ke4MzuV7HN9SRPBCnYEyoLmlpu5vbpMre1cYbrBQGu8auGxWdRCwWKFd
         +fp4LFLnT3qDCNCPBNw+8rLE0t9pUfb71G1UjGDy5D7P/nqpTmGez00jko7cK9KjGESX
         FjjYZtdKgOIA6LsCZ0wADU4CfISgfksbzNHUY+Bnba1GACwDf2A3j8S6CbLCjL0RkuAq
         vVCpJ4HSnmf1gwaAjV+KOqGAbr/x/15bmuyyVHKSmKbwPtiNRZjbErZMH4Kjn2z+GFUw
         2S/w==
X-Gm-Message-State: APjAAAUWFFBv4RySqAWExHeoBRzUd0VQ8gKxi0QHthUlHm0H4ZYhahtT
        ilKPWqBrZWhYUZvTNFriCagULMOi
X-Google-Smtp-Source: APXvYqxZdjF7sJBSwtdFB4EOHJ7PhweERhDE7zPTM3C9ao9UNMs9j9nl5+Qdw9XHQX1xUSi0Ycb79A==
X-Received: by 2002:a25:790d:: with SMTP id u13mr15723964ybc.286.1569855091171;
        Mon, 30 Sep 2019 07:51:31 -0700 (PDT)
Received: from ?IPv6:2600:1005:b126:5ad4:19ed:45d6:9df1:58e5? ([2600:1005:b126:5ad4:19ed:45d6:9df1:58e5])
        by smtp.gmail.com with ESMTPSA id s187sm2872221ywd.27.2019.09.30.07.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 07:51:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Kevin Vasko <kvasko@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: NFSv4 client locks up on larger writes with Kerberos enabled
Date:   Mon, 30 Sep 2019 09:51:23 -0500
Message-Id: <3A4773DD-A4E4-47BD-957A-E24E4604E390@gmail.com>
References: <20190926195557.GC2849@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
In-Reply-To: <20190926195557.GC2849@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: iPhone Mail (17A854)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

What does the GSS window control? I mentioned it in another thread somewhere=
 but I found out that clients with a slower connection seem to not exhibit t=
his issue.

All of these clients are local to the NFS server (in same room, which is in K=
orea). I=E2=80=99ve got clients in the USA and they don=E2=80=99t seem to ex=
hibit this lockup behavior. I haven=E2=80=99t done extensive testing but we c=
an get 3-4MB/s across the ocean and as of yet I haven=E2=80=99t see a client=
 from the USA lock up like the ones local. It obviously takes a lot longer b=
ut haven=E2=80=99t seen it lock up on transferring several 5GB+ files.=20

Could the GSS window not be overflowing with the slower connection and we wo=
uldn=E2=80=99t see the issue?=20

-Kevin

> On Sep 26, 2019, at 2:55 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> =EF=BB=BFOn Thu, Sep 26, 2019 at 08:55:17AM -0700, Chuck Lever wrote:
>>>> On Sep 25, 2019, at 1:07 PM, Bruce Fields <bfields@fieldses.org> wrote:=

>>> In that case--I seem to remember there's a way to configure the size of
>>> the client's slot table, maybe lowering that (decreasing the number of
>>> rpc's allowed to be outstanding at a time) would work around the
>>> problem.
>>=20
>>> Should the client be doing something different to avoid or recover from
>>> overflows of the gss window?
>>=20
>> The client attempts to meter the request stream so that it stays
>> within the bounds of the GSS sequence number window. The stream
>> of requests is typically unordered coming out of the transmit
>> queue.
>>=20
>> There is some new code (since maybe v5.0?) that handles the
>> metering: gss_xmit_need_reencode().
>=20
> I guess I was thinking he could write a small number (say 2 digits) into
> /sys/module/sunrpc/parameters/tcp_max_slot_table_entries (before
> mounting, I guess?) and see if the problem's reproducable.
>=20
> If not, that's a little more evidence that it's the gss sequence window.
>=20
> (And might be an adequate workaround for now.)
>=20
> --b.
