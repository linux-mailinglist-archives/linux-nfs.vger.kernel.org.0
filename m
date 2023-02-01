Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24038686845
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Feb 2023 15:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjBAO2q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Feb 2023 09:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjBAO2f (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Feb 2023 09:28:35 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D969311179
        for <linux-nfs@vger.kernel.org>; Wed,  1 Feb 2023 06:28:23 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id be8so18601621plb.7
        for <linux-nfs@vger.kernel.org>; Wed, 01 Feb 2023 06:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=shVBrDEa9IQP8/AEQcPRcvGr54IRcKjNo0iworGc8ks=;
        b=AeIULjGxaPXDjHR65oyMvwx1ONBSKxCeUWr35mmCF5hOCdX7kIHChn3XeoK29mHyPk
         DUOBKCQ/JkkCVgRB4NooqU+/xOn19XnazhjmQnApRqqL5H6Q0Q8us3/pp5wSJMtbjuhF
         sE65yvDcpqkGzUIGsEJ1mEG3Z7ajSUa2UhElhyxy5gXYRUSdS1Ssdo3EtLVdW6zDVY1d
         D2dnQ12ExjS8lsBiKuVqT9RmZOP19tns1qDU0+TYpIEDRcZFQV+ZVO3Cv2D309RZZ1Xf
         /U/uDeXZryENcdo7xk13IV3DBqNR5i8RHNon0NhIiHkyPYqyas4sLIRUH/GqC4BtMQC9
         GHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=shVBrDEa9IQP8/AEQcPRcvGr54IRcKjNo0iworGc8ks=;
        b=xt92HKnjDGleE4pz82YlzSJUbqtxdxS3zpsKun2nx5ggZG0lh2DEATzRj22dN+MbY+
         nlIJcv8m797RmZdDJKvLstephy3HQZ9ZHQWjkn68w4fLbp0QTlYZoj3WmZ6ddJY1tkAC
         RSjHKxMWbAStyhyq0oIr4DPKWb/DAg7wCY0phjbrHFtTPslgAYhwmWhdYc0sJHzWrXdw
         JbmJtWtg8CvUWomKGuTDjW6Q4jA1mrrdv1HfawNXarS2R5wI+rZHC5gaZVo9ONbQyTqO
         x9TmccMTiAxgOa+UERrht/m6HuU/9qy9heu1Z9yZ4tjVSRuNxI2w1hXtjrkcLGXbCbY4
         48ew==
X-Gm-Message-State: AO0yUKVS0vZtaQJ6CxnjDKweUfn53bZKOfPfXjOXJMi9UgZ7E9QEh770
        pfWzJ1k3HeBZKqZO2cpmopapf8w/RAXEg5kbBorXLXehBas=
X-Google-Smtp-Source: AK7set+693La+C4GitIYQP47RpUSMY4u5UZzx04VpNjG5k4ojHequhpcTXRyS5BbmeEHb2IFKFxeQLZTBJB+zjw1YZo=
X-Received: by 2002:a17:90a:7a8e:b0:230:2889:ec8b with SMTP id
 q14-20020a17090a7a8e00b002302889ec8bmr444077pjf.121.1675261703269; Wed, 01
 Feb 2023 06:28:23 -0800 (PST)
MIME-Version: 1.0
References: <YQBPR01MB10724B629B69F7969AC6BDF9586C89@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724AEE306F99C844101EED086CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR01MB10724F79460F3C02361279E8686CF9@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <654e3b7d15992d191b2b2338483f29aec8b10ee1.camel@kernel.org>
 <YQBPR01MB10724B36E378F493B9DED3C7E86D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <3c02bd2df703a68093db057c51086bbf767ffeb1.camel@kernel.org>
 <YQBPR01MB1072428BC706EE8C5CC34341186D39@YQBPR01MB10724.CANPRD01.PROD.OUTLOOK.COM>
 <936efa478e786be19cb9715eba1941ebc4f94a1b.camel@kernel.org>
 <SA1PR09MB75521717AA00DCAD6CAB5118A7D39@SA1PR09MB7552.namprd09.prod.outlook.com>
 <2bc328a4a292eb02681f8fc6ea626e83f7a3ae85.camel@kernel.org>
 <SA1PR09MB75528A7E45898F6A02EDF82EA7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
 <0BBE155A-CE56-40F7-A729-85D67A9C0CC3@oracle.com> <SA1PR09MB755212AB7E5C5481C45028A8A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
 <CAN-5tyHOJ=qXUU73VsZC9Ezs7_-eZ46VDtiE_DWB3bdyr768gA@mail.gmail.com>
 <SA1PR09MB7552C7543CE6E9D263C070D4A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
 <CAN-5tyGdaL_pYgqgS0TDwqCzVu=0rgLau8TDZMTe+hmC395UtQ@mail.gmail.com>
 <SA1PR09MB7552674B97042D59646F6EF1A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
 <CAN-5tyGQrW-DDa8E+jzwdJuJa1swtq31kd6u_0nPoZXwpJPu=g@mail.gmail.com> <SA1PR09MB7552AB9D248410D0DE9866B2A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
In-Reply-To: <SA1PR09MB7552AB9D248410D0DE9866B2A7D09@SA1PR09MB7552.namprd09.prod.outlook.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 1 Feb 2023 09:28:11 -0500
Message-ID: <CAN-5tyHnrFe5sZvd7MZ3NgdLhv8AyGUxu7ioJ3zb4ouj0Lq5Mw@mail.gmail.com>
Subject: Re: Zombie / Orphan open files
To:     "Andrew J. Romero" <romero@fnal.gov>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Jeff,

There doesn't need to be anything done by the administrators (not for
the linux implementation). The negotiation is specified in the spec.
In the EXCHANGE_ID the client has a eia_state_protection field which
it sets to SP4_MACH_CREDS and provides 2 lists must_enforce and
must_allow (here's the spec):

"The second list is spo_must_allow and consists of those operations
the client wants to have the option of sending with the machine
credential or the SSV-based credential, even if the object the
operations are performed on is not owned by the machine or SSV
credential.

The corresponding result, also called spo_must_allow, consists of the
operations the server will allow the client to use SP4_SSV or
SP4_MACH_CRED credentials with. Normally, the server's result equals
the client's argument, but the result MAY be different.

The purpose of spo_must_allow is to allow clients to solve the
following conundrum. Suppose the client ID is confirmed with
EXCHGID4_FLAG_BIND_PRINC_STATEID, and it calls OPEN with the
RPCSEC_GSS credentials of a normal user. Now suppose the user's
credentials expire, and cannot be renewed (e.g., a Kerberos ticket
granting ticket expires, and the user has logged off and will not be
acquiring a new ticket granting ticket). The client will be unable to
send CLOSE without the user's credentials, which is to say the client
has to either leave the state on the server or re-send EXCHANGE_ID
with a new verifier to clear all state, that is, unless the client
includes CLOSE on the list of operations in spo_must_allow and the
server agrees."

It's possible that the NAS storage didn't allow for the CLOSE to be
done with the machine creds and thus without user creds the state
would be left open on the server. I suggest you capture a network
trace during a mount and check the content of the reply.

On Tue, Jan 31, 2023 at 6:08 PM Andrew J. Romero <romero@fnal.gov> wrote:
>
> Hi Olga
>
> Based on Jeff's post
>
> Are there some NFS-client side flags that need to be set by
> the sys-admins to have the state-operations performed
> by the machine credential ?
>
> Are there any server-side requirements that must be fulfilled
> so that the correct behavior is negotiated between client and server ?
>
> What versions of the client ( RHEL-7 , 8 ..) support this behavior
> ( state-ops performed by machine credential )
>
> What versions of NFS ( 4.0, 4.1 .... ) support / mandate this behavior
>
> Thanks Again
>
> If any of you plan on visiting Illinois soon,  I owe you lunch !
>
> Andy
>
>
> >
> > Here's the paragraph of the spec stating that things like CLOSE must be allowed:
> >
> > In cases where the server's security policies on a portion of its
> > namespace require RPCSEC_GSS authentication, a client may have to use
> > an RPCSEC_GSS credential to remove per-file state (e.g., LOCKU, CLOSE,
> > etc.). The server may require that the principal that removes the
> > state match certain criteria (e.g., the principal might have to be the
> > same as the one that acquired the state). However, the client might
> > not have an RPCSEC_GSS context for such a principal, and might not be
> > able to create such a context (perhaps because the user has logged
> > off). When the client establishes SP4_MACH_CRED or SP4_SSV protection,
> > it can specify a list of operations that the server MUST allow using
> > the machine credential (if SP4_MACH_CRED is used) or the SSV
> > credential (if SP4_SSV is used).
> >
> > If the NAS vendor is disallowing it then they are in the wrong.
> >
