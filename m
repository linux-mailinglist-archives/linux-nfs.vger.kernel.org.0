Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0131694908
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Feb 2023 15:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjBMOz2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Feb 2023 09:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjBMOzR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Feb 2023 09:55:17 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5AE1C7F1
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 06:55:15 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id z14-20020a17090abd8e00b00233bb9d6bdcso7241010pjr.4
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 06:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4+FSl/mIoXHlgL/0elRlhzCS8DDB50anix21EAcSVE=;
        b=f6Y3oVczuDkinoqHbhEXDWEs8k//A4BuNQsPqoyjHaw2eOrJYGQBW9sWfil9qsjm3Z
         4rKqlH2Zf0vLaEvUSDV5rhY+ykKaAFEWFRcuv5St2ivR12BgXhy6z+B7sQAFFhmT/Ev+
         lIbAmFpVieFsPZxDIPKhVqV016aREQsUpSIqCPybb2Iew/lCdjlggArhs5Zqb1dfUswD
         MalGxhgUI3VPqwjlwvENvcK92ht2yL+KqEoZ3hS/FEim3rYOeFHmYlmfgkVWO0xRzwUo
         MG2Vo/aY0Z4orPFKXcLS2d3IHXTlzJG6kT1qlACzGhKgpTZ4plGm4ko44Fy7TBSPbudn
         KaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4+FSl/mIoXHlgL/0elRlhzCS8DDB50anix21EAcSVE=;
        b=rkIILMoDWQ39IfISY6vaTga5qHh86im31GLrlndhb7FJdirwyncY60tpTYB28UwW67
         pG5rTf2Mekn6gZAa5FTC/AWshxjEeHeZiuNlNWdT8WpZvju65nbkOHgXRbBOVBfa0b5J
         miiCOhM5ylrB1DgJ97cqxtlZ1XiTr10/x/34gK6CV/sQsEM3MeJsjrV0Ocqf7mxJIWih
         Mfm6DD4CBH9cB+b09vb274GFi55gnvJqBT5uVBcc6sfFZymLBoWO6FxMdMHmBQmN5QMM
         Lu4VzJST3evqrBuxfgQTRUqjXq3HzB0+j1A/UWLX1ZJqrDP9noNQKD7eSdPmOQOP1anf
         1JeA==
X-Gm-Message-State: AO0yUKXMIiUIOG67oj34kg7sWUxxsBCi1rROuDKPlh1Q4ZeSnS3IlwB/
        Dg2etTKnNhxhFKGqaY8+SM6Hu1Yem2xKdMpkQhk=
X-Google-Smtp-Source: AK7set8IVzV2VQI2SydyX1kGYwX0xKDg7kAM/AN8Pj+WHqydupwLf4JyRh1Qe6SSc1+F5xNV5juvstc2KfgqKaTJ5J4=
X-Received: by 2002:a17:90a:55c9:b0:233:e082:ac1d with SMTP id
 o9-20020a17090a55c900b00233e082ac1dmr1106715pjm.121.1676300114491; Mon, 13
 Feb 2023 06:55:14 -0800 (PST)
MIME-Version: 1.0
References: <20230212140148.4F0D.409509F4@e16-tech.com> <A2C070C8-3B50-4B11-B07B-99FE93F9BA16@oracle.com>
In-Reply-To: <A2C070C8-3B50-4B11-B07B-99FE93F9BA16@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Mon, 13 Feb 2023 09:55:03 -0500
Message-ID: <CAN-5tyE-DfbJOZCLzpgfEt+2u=UogLKn_gKs6mDbYpRUq+WXsA@mail.gmail.com>
Subject: Re: question about the performance impact of sec=krb5
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Wang Yugui <wangyugui@e16-tech.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Feb 12, 2023 at 1:08 PM Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>
>
>
> > On Feb 12, 2023, at 1:01 AM, Wang Yugui <wangyugui@e16-tech.com> wrote:
> >
> > Hi,
> >
> > question about the performance of sec=3Dkrb5.
> >
> > https://learn.microsoft.com/en-us/azure/azure-netapp-files/performance-=
impact-kerberos
> > Performance impact of krb5:
> >       Average IOPS decreased by 53%
> >       Average throughput decreased by 53%
> >       Average latency increased by 3.2 ms
>
> Looking at the numbers in this article... they don't
> seem quite right. Here are the others:
>
> > Performance impact of krb5i:
> >       =E2=80=A2 Average IOPS decreased by 55%
> >       =E2=80=A2 Average throughput decreased by 55%
> >       =E2=80=A2 Average latency increased by 0.6 ms
> > Performance impact of krb5p:
> >       =E2=80=A2 Average IOPS decreased by 77%
> >       =E2=80=A2 Average throughput decreased by 77%
> >       =E2=80=A2 Average latency increased by 1.6 ms
>
> I would expect krb5p to be the worst in terms of
> latency. And I would like to see round-trip numbers
> reported: what part of the increase in latency is
> due to server versus client processing?
>
> This is also remarkable:
>
> > When nconnect is used in Linux, the GSS security context is shared betw=
een all the nconnect connections to a particular server. TCP is a reliable =
transport that supports out-of-order packet delivery to deal with out-of-or=
der packets in a GSS stream, using a sliding window of sequence numbers.=E2=
=80=AFWhen packets not in the sequence window are received, the security co=
ntext is discarded, and=E2=80=AFa new security context is negotiated. All m=
essages sent with in the now-discarded context are no longer valid, thus re=
quiring the messages to be sent again. Larger number of packets in an nconn=
ect setup cause frequent out-of-window packets, triggering the described be=
havior. No specific degradation percentages can be stated with this behavio=
r.
>
>
> So, does this mean that nconnect makes the GSS sequence
> window problem worse, or that when a window underrun
> occurs it has broader impact because multiple connections
> are affected?

Yes nconnect makes the GSS sequence window problem worse (very typical
to generate more than gss window size number of rpcs and have no
ability to control in what order they would be sent) and yes all
connections are affected. ONTAP as linux uses 128 gss window size but
we've experimented with increasing it to larger values and it would
still cause issues.

> Seems like maybe nconnect should set up a unique GSS
> context for each xprt. It would be helpful to file a bug.

At the time when I saw the issue and asked about it (though can't find
a reference now) I got the impression that having multiple contexts
for the same rpc client was not going to be acceptable.



>
>
> > and then in 'man 5 nfs'
> > sec=3Dkrb5  provides cryptographic proof of a user's identity in each R=
PC request.
>
> Kerberos has performance impacts due to the crypto-
> graphic operations that are performed on even small
> fixed-sized sections of each RPC message, when using
> sec=3Dkrb5 (no 'i' or 'p').
>
>
> > Is there a option of better performance to check krb5 only when mount.n=
fs4,
> > not when file acess?
>
> If you mount with NFSv4 and sec=3Dsys from a Linux NFS
> client that has a keytab, the client will attempt to
> use krb5i for lease management operations (such as
> EXCHANGE_ID) but it will continue to use sec=3Dsys for
> user authentication. That's not terribly secure.
>
> A better answer would be to make Kerberos faster.
> I've done some recent work on improving the overhead
> of using message digest algorithms with GSS-API, but
> haven't done any specific measurement. I'm sure
> there's more room for optimization.
>
> Even better would be to use a transport layer security
> service. Amazon has EFS and Oracle Cloud has something
> similar, but we're working on a standard approach that
> uses TLSv1.3.
>
>
> --
> Chuck Lever
>
>
>
