Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF301694AE9
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Feb 2023 16:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjBMPTF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Feb 2023 10:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjBMPTC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Feb 2023 10:19:02 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C251D30F1
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 07:18:58 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id w20-20020a17090a8a1400b00233d7314c1cso4673431pjn.5
        for <linux-nfs@vger.kernel.org>; Mon, 13 Feb 2023 07:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvFz5RI/bCNl1zvYOcfdlOPIjKTsWoS/G46Sjksdq3U=;
        b=NHt5kv/h4aVIET8hXbByPPt5ignhGcLRp6191vXKQJUBdwgEdNHv6b+tKbls7YMXgT
         hrowwIp7OrwjFg5zf8w1vGSB/e3mAxxOvQ0AW0tKWfq1POOcjZLPkPveqRVZ6rXOi8/9
         Flr3ne7/m9drAxX+ljGhfcSiGjbN5K0Lkr5U+uDCM3tvGSs/iz4SpRuEVundKP4Uptmv
         FVBUCxdj0tEQxsfbzaS0fDe4vSK2bkILe+xLcDjFa4sKEgz7cNUSzjFfAw4qSHYN0djz
         Onxbg2Hrj5fN2LAFDO1KcPtID1Q0pe8XUiESDCDbUm2nnWO2WP24JBNj+oBAz6n0p4cm
         pvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvFz5RI/bCNl1zvYOcfdlOPIjKTsWoS/G46Sjksdq3U=;
        b=3Ez3kXEBCyfmWcO45xdnPojaJv8/hel0V7ZY+POXlmjHRF8lYZ2Bs/6ZdLnbJfXIF3
         mMMCa22rGsXefYdnd29Q35/CcPtgWOaJJ0pJVEqxNBjlvvZAmgBtMTeLRo8Pdhgb39Ef
         hI8Z5+2vjMkBWJlp6v+dOPDuJcDrrcU4vc2kei9duboe0Oa0ChPMkbve7JkBYmx3qCq8
         WLqM0GsuoJzXTQ9oEJuGEU1+npG0lAztrO+psiN78FUxvu1ha5OfBGBB8yb5R1Ks+TV1
         05UMXv+F1p0919h9WStBm335xhEH8bElQi5FMlzSxyQla06Sctacr6jtPwzcCq3NYkoA
         /jVQ==
X-Gm-Message-State: AO0yUKXLTeIuq54sDqXaBiThFWMoRrPkfdEbBuh8FNZNYs6VvcHFfWW1
        RSuUNLs+1AyOB8UDBd+iQcapHvCz6cUcN7Z0tQ==
X-Google-Smtp-Source: AK7set+fNQ18uGeZpG7yneNm03nlP7mkz5T92uM9P7tmLTcAyj8g1pvLzqh9qWoyWYFJLMgx9VZ4vc+l/bN7ODfy+4E=
X-Received: by 2002:a17:90a:7605:b0:233:c74a:137e with SMTP id
 s5-20020a17090a760500b00233c74a137emr1656743pjk.79.1676301537816; Mon, 13 Feb
 2023 07:18:57 -0800 (PST)
MIME-Version: 1.0
References: <20230212140148.4F0D.409509F4@e16-tech.com> <A2C070C8-3B50-4B11-B07B-99FE93F9BA16@oracle.com>
 <CAN-5tyE-DfbJOZCLzpgfEt+2u=UogLKn_gKs6mDbYpRUq+WXsA@mail.gmail.com>
In-Reply-To: <CAN-5tyE-DfbJOZCLzpgfEt+2u=UogLKn_gKs6mDbYpRUq+WXsA@mail.gmail.com>
From:   Rick Macklem <rick.macklem@gmail.com>
Date:   Mon, 13 Feb 2023 07:18:45 -0800
Message-ID: <CAM5tNy6oCkzNTtGYoWgy+qPfwuwcjz7r3t7Zi47mcz4xT77ydw@mail.gmail.com>
Subject: Re: question about the performance impact of sec=krb5
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Feb 13, 2023 at 6:55 AM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> CAUTION: This email originated from outside of the University of Guelph. =
Do not click links or open attachments unless you recognize the sender and =
know the content is safe. If in doubt, forward suspicious emails to IThelp@=
uoguelph.ca
>
>
> On Sun, Feb 12, 2023 at 1:08 PM Chuck Lever III <chuck.lever@oracle.com> =
wrote:
> >
> >
> >
> > > On Feb 12, 2023, at 1:01 AM, Wang Yugui <wangyugui@e16-tech.com> wrot=
e:
> > >
> > > Hi,
> > >
> > > question about the performance of sec=3Dkrb5.
> > >
> > > https://learn.microsoft.com/en-us/azure/azure-netapp-files/performanc=
e-impact-kerberos
> > > Performance impact of krb5:
> > >       Average IOPS decreased by 53%
> > >       Average throughput decreased by 53%
> > >       Average latency increased by 3.2 ms
> >
> > Looking at the numbers in this article... they don't
> > seem quite right. Here are the others:
> >
> > > Performance impact of krb5i:
> > >       =E2=80=A2 Average IOPS decreased by 55%
> > >       =E2=80=A2 Average throughput decreased by 55%
> > >       =E2=80=A2 Average latency increased by 0.6 ms
> > > Performance impact of krb5p:
> > >       =E2=80=A2 Average IOPS decreased by 77%
> > >       =E2=80=A2 Average throughput decreased by 77%
> > >       =E2=80=A2 Average latency increased by 1.6 ms
> >
> > I would expect krb5p to be the worst in terms of
> > latency. And I would like to see round-trip numbers
> > reported: what part of the increase in latency is
> > due to server versus client processing?
> >
> > This is also remarkable:
> >
> > > When nconnect is used in Linux, the GSS security context is shared be=
tween all the nconnect connections to a particular server. TCP is a reliabl=
e transport that supports out-of-order packet delivery to deal with out-of-=
order packets in a GSS stream, using a sliding window of sequence numbers.=
=E2=80=AFWhen packets not in the sequence window are received, the security=
 context is discarded, and=E2=80=AFa new security context is negotiated. Al=
l messages sent with in the now-discarded context are no longer valid, thus=
 requiring the messages to be sent again. Larger number of packets in an nc=
onnect setup cause frequent out-of-window packets, triggering the described=
 behavior. No specific degradation percentages can be stated with this beha=
vior.
> >
> >
> > So, does this mean that nconnect makes the GSS sequence
> > window problem worse, or that when a window underrun
> > occurs it has broader impact because multiple connections
> > are affected?
>
> Yes nconnect makes the GSS sequence window problem worse (very typical
> to generate more than gss window size number of rpcs and have no
> ability to control in what order they would be sent) and yes all
> connections are affected. ONTAP as linux uses 128 gss window size but
> we've experimented with increasing it to larger values and it would
> still cause issues.
>
> > Seems like maybe nconnect should set up a unique GSS
> > context for each xprt. It would be helpful to file a bug.
>
> At the time when I saw the issue and asked about it (though can't find
> a reference now) I got the impression that having multiple contexts
> for the same rpc client was not going to be acceptable.
>
I suspect there might be awkward corner cases if there are multiple
contexts for a given user principal.
For example:
- If the group database changed at about the same time as the
  context was established, you might get two contexts for a user
  that map to different sets of groups on the server.
- If a user renewed a TGT at about the time the contexts were being
  created on the client, I think they could end up with different expiry
  times.

These are just off the top of my head, but I suspect there are issues
when you create multiple contexts for a given user?

rick

>
>
> >
> >
> > > and then in 'man 5 nfs'
> > > sec=3Dkrb5  provides cryptographic proof of a user's identity in each=
 RPC request.
> >
> > Kerberos has performance impacts due to the crypto-
> > graphic operations that are performed on even small
> > fixed-sized sections of each RPC message, when using
> > sec=3Dkrb5 (no 'i' or 'p').
> >
> >
> > > Is there a option of better performance to check krb5 only when mount=
.nfs4,
> > > not when file acess?
> >
> > If you mount with NFSv4 and sec=3Dsys from a Linux NFS
> > client that has a keytab, the client will attempt to
> > use krb5i for lease management operations (such as
> > EXCHANGE_ID) but it will continue to use sec=3Dsys for
> > user authentication. That's not terribly secure.
> >
> > A better answer would be to make Kerberos faster.
> > I've done some recent work on improving the overhead
> > of using message digest algorithms with GSS-API, but
> > haven't done any specific measurement. I'm sure
> > there's more room for optimization.
> >
> > Even better would be to use a transport layer security
> > service. Amazon has EFS and Oracle Cloud has something
> > similar, but we're working on a standard approach that
> > uses TLSv1.3.
> >
> >
> > --
> > Chuck Lever
> >
> >
> >
