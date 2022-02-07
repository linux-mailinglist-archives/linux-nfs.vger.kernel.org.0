Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D33F4AC3F5
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 16:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiBGPeK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 10:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbiBGPWU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Feb 2022 10:22:20 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9BAC0401C1
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 07:22:19 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id u18so30481774edt.6
        for <linux-nfs@vger.kernel.org>; Mon, 07 Feb 2022 07:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xG2PTqPQIy4xTSQWDcoSwjnaM4ib/qNpiBdxqfrXLqg=;
        b=Hv+yz2rAxKtkqAj9+u+PcpBNokTp9G6v/qNQvdnOe206TtHMpCV1g11s+RXa9X+dXH
         HFCByqJNwy9gb+oiCPyWX59ssBvIi0zk9tqMa4Yytt0nLYlHOQPAspaLV4l+dC1An1am
         ohyZW9QkJaFucKvdpLShxEGPrDPowlxM1NTAtfGqkLO/1FGMxo7d9nLCHAplriFxDDhy
         M2CLTYMRhEDo0DXQBV82CWizjiSy+YKYXyT/nORSQS4M8sSC9geydvDsxirqiM6+19s+
         75DcK7VIYo/qtpCuxxnHn2LAhwMo1JMeOklvYEMHTgPj+6Rm+qnqdXuC3Nd+SdRx9OOS
         yJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xG2PTqPQIy4xTSQWDcoSwjnaM4ib/qNpiBdxqfrXLqg=;
        b=x20A4XhB0uOgcm8HsdrXSPI+7Tn+W6rBY1flDSANq0A2SabXr4caxKJv9VcOtFN8RE
         wu7I6n0y5yV+Lm9XTJT8oZg9uH5C2iuwcAnniksFYu8q/ikTj3xWwp3J+Xz0q3sdmcf9
         ReGj1EXVmb2WNCstj/C2oUGVopLSQ+7WfyXaMLlTL87h3Xx6QGs8j5lz46pB4lE8MOw0
         VcGzLmj95rr1ylATSF7SPO48pG9FX7BooFRY3npBmYkiUZo0JXSuSoUkpeFqs6fqQz+k
         5Dnbz3LH/JZgGq/BlknNuMgM/2VWNSn2n+N0y/K8MMAzPjzLHUix13MZVMasLorhwOfs
         2qMw==
X-Gm-Message-State: AOAM530BMsF1Hvlbr41M9v6z5dc9s9nAGYPlIOcwyMeI+YTbjV+ZuLQw
        FJUZ9y1/1UZGrnVZ8knNLHBOSRv+easgqCMXzAUGJqHgIChWMbeU
X-Google-Smtp-Source: ABdhPJyViZPrx+8IZkJOntm9sSklAM/LPE2xOf2flS9O91M2ez1K2NfKEri2tdXZAkNpoKkkSzqRus7rduOZdWuOtew=
X-Received: by 2002:a05:6402:3594:: with SMTP id y20mr15073616edc.386.1644247337859;
 Mon, 07 Feb 2022 07:22:17 -0800 (PST)
MIME-Version: 1.0
References: <CAPt2mGNF=iZkXGa93yjKQG5EsvUucun1TMhN5zM-6Gp07Bni2g@mail.gmail.com>
 <20220107171755.GD26961@fieldses.org> <CAPt2mGPtxNzigMEYXKFX0ayVc__gyJcQJVHU51CKqU+ujqh7Cg@mail.gmail.com>
 <20220110145210.GA18213@fieldses.org> <20220110172106.GC18213@fieldses.org>
 <CAPt2mGPUa_VHHshXwLLCH=wvdrd6Hyb4gttMeEqKdgFV4GJY7g@mail.gmail.com>
 <20220123224238.GA9255@fieldses.org> <CAPt2mGMXHqBtWJhuEM76MY5tm0V=uAghKT21KRsHBQAfgkuJpg@mail.gmail.com>
In-Reply-To: <CAPt2mGMXHqBtWJhuEM76MY5tm0V=uAghKT21KRsHBQAfgkuJpg@mail.gmail.com>
From:   Daire Byrne <daire@dneg.com>
Date:   Mon, 7 Feb 2022 15:21:41 +0000
Message-ID: <CAPt2mGN-fqG3nMnrtaa8jWQpkTZYqQuWAR+EseD0d7CCfEPmzw@mail.gmail.com>
Subject: Re: nconnect & repeating BIND_CONN_TO_SESSION?
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond kindly posted a patch to fix the noresvport mount issue with
v4.2 and recent kernels.

I tested it quickly and verified ports greater than 1024 were being
used as expected, but it seems the same issue persists. It still feels
like it's related to the total number of server + nconnect pairings.

So I can have 20 servers mounted with nconnect=4 or 10 servers mounted
with nconnect=8 but any combination that increases the total
connection on the client past that and at least one of the servers
ends up in a state such that it's just sending a bind_conn_to_session
with every operation.

I'll see if I can discern anything from any packet capture (as
suggested earlier by Rick), but it's hard to reproduce exactly in time
and on demand. My theory is that maybe there is a timeout on the
callback and that adding more connections is just adding more
load/throughput and making a timeout more likely.

My workaround atm is to simply use NFSv3 instead of NFSv4 which might
be a better choice for this kind of workload anyway.

Daire


On Mon, 24 Jan 2022 at 12:33, Daire Byrne <daire@dneg.com> wrote:
>
> On Sun, 23 Jan 2022 at 22:42, J. Bruce Fields <bfields@fieldses.org> wrote:
> > > I suspect it's just more recent kernels that has lost the ability to
> > > use v4+noresvport
> >
> > Yes, thanks for checking that.  Let us know if you narrow down the
> > kernel any more.
>
> https://bugzilla.kernel.org/show_bug.cgi?id=215526
>
> I think it stopped working somewhere between v5.11 and v5.12. I'll try
> and bisect it this week.
>
> Daire
