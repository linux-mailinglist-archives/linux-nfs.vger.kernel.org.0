Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A414357FF16
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Jul 2022 14:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbiGYMiz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Jul 2022 08:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiGYMiy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Jul 2022 08:38:54 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85619BC98
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:53 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 921AC3F11B
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 12:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1658752731;
        bh=/s8WgxQHA6c84G+j/sEDuFHNsm+gnyFCTO4yO2BftJY=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=cxgCBsoETkOUaFPuAcL5bGoNkmj+5Jh7YYQdKMOjPf/eb3irFsCe75T21MiqFsnid
         qZcDQyZ7VtIWdTK1fSmcG7UEF/m+6/NLFdDLYPABcmk3B2c9PNfmvxgHKZ4NIABoCj
         qmCBYoE7C7uRY9r5JwNn/ycv+Qpd88EY9BcBCDz/pL7lhVEliS8MNEcvh2wRH6l49M
         Sa6nq0/U6y9B4mMAF5kTZm/Z2Rw7LOjhi4yMPoqflSw9AhSnyF6M3juZnOHS+ine43
         KCc37Xr+TYxmjWaMmmzxWaJ7YSeo8v6QkjMdkEgmu6uH70aWCK3cef9rS/0VBiBQaW
         j4XdQPEwIbfeQ==
Received: by mail-ej1-f71.google.com with SMTP id hq20-20020a1709073f1400b0072b9824f0a2so3143234ejc.23
        for <linux-nfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/s8WgxQHA6c84G+j/sEDuFHNsm+gnyFCTO4yO2BftJY=;
        b=cuwHQ+0dL2LSU+BB+NJlMg2yg7KGPzCiCbGUSWJuowv+WWJ17U3L49tfUK/nWHlYqW
         VaD4GtpWjzdMG9YSZEOXoZyMcnF7HlxgAcyCqF7MhFzJ2usCTha1UtLK9eMPGtPKLgtt
         zBrBqSIuxCqUst3A5i6X6F4wFUxh2ocfW7dnLcVQ2pE8mkUix+pSW1BzNcOMRghkp2+l
         DIYhSVkC096KYN692p6wWFXoWk/G6h7R+UPkATieyxYEf6hS4UIMkUPMc1ECTqU/nvzd
         2orUch1NB4apYqZzbjP+BD4F+uuLjlXlpWGFrff/cnOFu2GnC1CNqapQxLfSo1+YqgLF
         x+qg==
X-Gm-Message-State: AJIora+8UT3aGbnXozlky3ScFEX8ny6Kl77JsLh/9DtLbGQWEGiphyPU
        MNdZXDWRgbQmtjgA1qMKqGUxycZDXdZEgVAsaNzE4qLCpP9biebi5hvm5IlZo63Fq2G/e7Hks+r
        NsVBCGNdeNHj8WBaFM1yl2bqWfIi2RnjFxGkR+fEIN34/CcjnTN2Z6A==
X-Received: by 2002:a05:6402:48d:b0:43a:cccd:89d9 with SMTP id k13-20020a056402048d00b0043acccd89d9mr13390668edv.257.1658752731355;
        Mon, 25 Jul 2022 05:38:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1syT69lopTQ5o2t2HUHWOPrrdqu7Scq3H2NXrHWyxD8McIVCuCb62B8WDXTx6rzoar7FiroxwB647KYL21fH4g=
X-Received: by 2002:a05:6402:48d:b0:43a:cccd:89d9 with SMTP id
 k13-20020a056402048d00b0043acccd89d9mr13390654edv.257.1658752731158; Mon, 25
 Jul 2022 05:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <CANYNYEFSdBua3Ay6jGk2cacossVJ8_CzDgDBnFCjXfk5XSoGEQ@mail.gmail.com>
 <EE39279C-4E40-48C8-ABC9-707EB1AD6D79@redhat.com> <7bfafe56-0c13-a32d-093b-4d3684c4f2c7@redhat.com>
In-Reply-To: <7bfafe56-0c13-a32d-093b-4d3684c4f2c7@redhat.com>
From:   Andreas Hasenack <andreas@canonical.com>
Date:   Mon, 25 Jul 2022 09:38:40 -0300
Message-ID: <CANYNYEEA1CHwvZhrr2W0-BcGR1Rm50QSTdHwb0pygz4z0ZY=uQ@mail.gmail.com>
Subject: Re: Why keep var-lib-nfs-rpc_pipefs.mount around?
To:     Steve Dickson <steved@redhat.com>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

On Sat, Jul 23, 2022 at 2:29 PM Steve Dickson <steved@redhat.com> wrote:
>
> My apologies delayed response... extended PTO
>
> On 7/11/22 9:13 AM, Benjamin Coddington wrote:
> > On 8 Jul 2022, at 12:50, Andreas Hasenack wrote:
> >
> >> Hi,
> >>
> >> I was tracking down a Debian/Ubuntu bug with nfs-utils 2.6.1 where in
> >> one case, after installing the packages, you would end up with
> >> rpc_pipefs mounted at the same time in two locations: /run/rpc_pipefs
> >> and /var/lib/nfs/rpc_pipefs. The /run location is what debian/ubuntu
> >> default to.
> >>
> >> After poking around a bit, I think I found out why that is
> >> happening[1], but it led me to ask this question: why is
> >> var-lib-nfs-rpc_pipefs.mount (and its corresponding rpc_pipefs.target
> >> unit) still shipped, given that nfs-utils now has a generator?
> >
> > Could just be an oversight, or perhaps a better reason exists.  The
> > nfs-utils userspace has to handle a lot of different cases and legacy
> > setups.
> >
> > Steve D, do you know?
> Its not clear to me, if the read from nfs.conf does not
> happen how changing the rpc_pipefs directory could happen.

The read happens, it's just that in that particular bug scenario, the
/etc/nfs.conf file isn't there yet.

In the debian case, two things are triggering this bug[1]:
- the /etc/nfs.conf file is not shipped by the package in that
location. Instead, it's put in place by the postinst script (like
rpm's %postinst)[2].
- autofs recommends[3], not depends, nfs-common. This means that
autofs can be setup before nfs-common is, and if that happens,
/etc/nfs.conf doesn't exist yet. But the nfs-common systemd unit files
do exist, and the generator is run when autofs calls systemctl
daemon-reload in its postinst. Since there is no /etc/nfs.conf, the
generator exits silently.

> When the read from nfs.conf happens and the rpc_pipefs directory
> is not defined, the compiled in default rpc_pipefs directory

Or if /etc/nfs.conf isn't there, the generator exits silently.

> will be used and the generator will exit and not
> generating the systemd files (using the installed ones).
>
> If the rpc_pipefs directory is defined in nfs.conf, the
> generator will set up that directory as the
> rpc_pipefs directory and systemd files will be
> generated.
>
> So by taking out the nfs.conf read, the only way to change
> the default rpc_pipefs directory is to recompile nfs-utils.

Actually, I'm doing two things:
- taking out the var-lib-nfs-rpc_pipefs.mount and rpc_pipefs.target units
- taking out the bit from the generator that compares the configured
pipefs directory with the compile-time default:
--- a/systemd/rpc-pipefs-generator.c
+++ b/systemd/rpc-pipefs-generator.c
@@ -139,9 +139,6 @@ int main(int argc, char *argv[])
     s = conf_get_str("general", "pipefs-directory");
     if (!s)
         exit(0);
-    if (strlen(s) == strlen(RPC_PIPEFS_DEFAULT) &&
-            strcmp(s, RPC_PIPEFS_DEFAULT) == 0)
-        exit(0);

     if (is_non_pipefs_mountpoint(s))
         exit(1);

Therefore I'm fully relying on the generator all the time, whatever
the pipefs directory is. And my question is wouldn't this be a sane
default behavior for all users of nfs-utils, instead of having the
extra complication of having two units for each of rpc_pipefs mount
and target? Did I miss something?

Unfortunately I haven't heard back yet from the debian maintainer
about this.[4] Maybe there is a "debian packaging" way to fix this. I
also thought about systemd conditionals on /etc/nfs.conf, but then I
would probably have to add them to a bunch of units (all of them?).

1. https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1014429
2. https://salsa.debian.org/kernel-team/nfs-utils/-/blob/master/debian/nfs-common.postinst#L9
3. https://salsa.debian.org/debian/autofs/-/blob/master/debian/control#L35
4. https://salsa.debian.org/kernel-team/nfs-utils/-/merge_requests/18
