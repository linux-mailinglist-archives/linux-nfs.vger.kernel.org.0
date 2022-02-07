Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E334ACAAA
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 21:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiBGUr6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 15:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241998AbiBGUdB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Feb 2022 15:33:01 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776FEC0401DA
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 12:33:00 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so169711wms.3
        for <linux-nfs@vger.kernel.org>; Mon, 07 Feb 2022 12:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QiSzydt75vpeh+kbY5uWezRho2t2WW2R3OefLp4T3NY=;
        b=GnawVETPWfG/XCCH4ikk+sLZ9H2/RK3zpZ88k+tPiahA+g8JCGA1BbdPXjsYl5bmcB
         ILxYaIyBE1XPXUv9h4YqkL3mFqSt/kyGSXYHcoXIzuTsEBlE2FU0sSCEE+vt6H6VmNlT
         XcnbRuhWy1DLi3Oqb5zb5ZpCnUf6oiQRO28yQ51FYyosTDXbv3wfmnx7esQTG9hi7HBJ
         b7J6JwdNFQgC6323zIP+AnCCOHZZuo4sCAKL27ND5XcVfaJiddHsONUENm1zKHVG/T35
         Whx6vT63OAeDJ8y8aTFdU6183YsnEGzszDh0ZGB9ORctnBZ9fvKnDu6OARqYedfE0O8d
         sL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QiSzydt75vpeh+kbY5uWezRho2t2WW2R3OefLp4T3NY=;
        b=R8rMfc7WAdwDYlxCQwcsPNwvfA/XIZYIvoANyG8y36I6Ae5KLdV87G3UFkVIdt3h1y
         CDU5YDR9mYy56+WjBTj5kThLqJcevq1Vj0oCXE1iM+73Eb6kN1LPz3ZdcBq9xKVswhAR
         a2A0kW+wzihLJJiZzY7CHxcV6Ld1UK+QiZVmk/xFqwauOZgNFD2KxZToNQ7Ufummm1Wx
         EKiU5VUmXkxih9e/v9XW010ahGzMrL+kJCXkoBfMMqcZ6RHYFYODDZ3wh7KGCT3nkZXW
         eabUnr9N2woK0GxGMrjZ0+A7f1aWLHjRPwk7oNUrHKR+WZslFm3z1PYUSf43NmVdIH4J
         pktw==
X-Gm-Message-State: AOAM530aj8y+x5japeEicjEnKJBWPt7gLwjBfSoNYlRNXhtOkbDUougQ
        dDcbjZCNXSyF0NLhv0M5lCyM/u5rq73VctTzWWc=
X-Google-Smtp-Source: ABdhPJwRV1k+yKVlSUazgXZmxSTWAWMK5zT0I1HfccAchoGA4DKu5d7Im19kNVaykuQyQP67zVnaKWNeESEekE2WqwQ=
X-Received: by 2002:a1c:a595:: with SMTP id o143mr364305wme.78.1644265978793;
 Mon, 07 Feb 2022 12:32:58 -0800 (PST)
MIME-Version: 1.0
References: <20220127194952.63033-1-Anna.Schumaker@Netapp.com>
 <20220127194952.63033-9-Anna.Schumaker@Netapp.com> <c416e70b-35c6-6b8c-df04-ed496e9a978d@redhat.com>
In-Reply-To: <c416e70b-35c6-6b8c-df04-ed496e9a978d@redhat.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Mon, 7 Feb 2022 15:32:42 -0500
Message-ID: <CAFX2Jfmg-B-KHmeUkBPV0ohxPAmJOw4ioYoLVVLpFOQ_OWLE=w@mail.gmail.com>
Subject: Re: [PATCH v7 8/9] rpcctl: Add a man page
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Schumaker Anna <Anna.Schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Feb 7, 2022 at 2:58 PM Steve Dickson <steved@redhat.com> wrote:
>
> Hey Anna!
>
> On 1/27/22 2:49 PM, schumaker.anna@gmail.com wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > ---
> >   tools/rpcctl/rpcctl.man | 88 +++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 88 insertions(+)
> >   create mode 100644 tools/rpcctl/rpcctl.man
> >
> > diff --git a/tools/rpcctl/rpcctl.man b/tools/rpcctl/rpcctl.man
> > new file mode 100644
> > index 000000000000..e4dd53ac8531
> > --- /dev/null
> > +++ b/tools/rpcctl/rpcctl.man
> > @@ -0,0 +1,88 @@
> > +.\"
> > +.\" rpcctl(8)
> > +.\"
> > +.TH rpcctl 8 "25 Jan 2022"
> > +.SH NAME
> > +rpcctl \- Displays SunRPC connection information
> > +.SH SYNOPSIS
> > +.B rpcctl
> > +.RB [ \-h | \-\-help ]
> > +.P
> > +.B rpcctl client
> > +.RB [ \-h | \-\-help ]
> > +.RB [ \--id
> > +.IR ID ]
> > +.P
> > +.B rpcctl switch
> > +.RB [ \-h | \-\-help ]
> > +.RB [ \--id
> > +.IR ID ]
> > +.P
> > +.B rpcctl switch set
> > +.RB [ \-h | \-\-help ]
> > +.RB [ \--id
> > +.IR ID ]
> > +.RB [ \--dstaddr
> > +.IR dstaddr]
> > +.P
> > +.B rpcctl xprt
> > +.RB [ \-h | \-\-help ]
> > +.RB [ \--id
> > +.IR ID ]
> > +.P
> > +.B rpcctl xprt set
> > +.RB [ \-h | \-\-help ]
> > +.RB [ \--id
> > +.IR ID ]
> > +.RB [ \--dstaddr
> > +.IR dstaddr]
> > +.RB [ --offline ]
> > +.RB [ --online ]
> > +.RB [ --remove ]
> > +.P
> > +.SH DESCRIPTION
> > +.RB "The " rpcctl " command displays information collected in the SunRPC sysfs files about the system's SunRPC objects.
> > +.P
> > +.SS Objects
> > +Valid
> > +.BR rpcctl (8)
> > +objects are:
> > +.IP "\fBclient\fP"
> > +Display information about this system's RPC clients.
> > +.IP "\fBswitch\fP"
> > +Display information about groups of transports.
> > +.IP "\fBxprt\fP"
> > +Display detailed information about each transport that exists on the system.
> > +.SH OPTIONS
> > +.SS Options valid for all objects
> > +.TP
> > +.B \-h, \-\-help
> > +Show the help message and exit
> > +.TP
> > +.B \-\-id \fIID
> > +Set or display properties for the object with the given
> > +.IR ID.
> > +This option is mandatory for setting properties.
> > +.SS Options specific to the `switch set` sub-command
> > +.TP
> > +.B \-\-dstaddr \fIdstaddr
> > +Change the destination address of all transports in the switch to
> > +.IR dstaddr
> > +.SS Options specific to the `xprt set` sub-command
> > +.TP
> > +.B \-\-dstaddr \fIdstaddr
> > +Change the destination address of this specific transport to
> > +.TP
> > +.B \-\-offline
> > +Change the transport state from online to offline
> > +.TP
> > +.B \-\-online
> > +Change the transport state from offline to online
> > +.TP
> > +.B \-\-remove
> > +Removes the transport from the switch. Note that "main" transports cannot be removed.
> I got some feed back on this manpage....
>
> They said would be useful to have examples on how to use
> the objects... esp the switch set and xprt set ones.
> I kinda agree...

Okay, I can add that. I'll send out a new version with that and
anything Rahul finds once he checks back in after trying the tool with
the sysfs kernel fixes.

Anna

>
> steved.
> > +.SH DIRECTORY
> > +.TP
> > +.B /sys/kernel/sunrpc/
> > +.SH AUTHOR
> > +Anna Schumaker <Anna.Schumaker@Netapp.com>
>
