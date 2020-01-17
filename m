Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB6B8140A85
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 14:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgAQNQy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 08:16:54 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:38836 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgAQNQy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jan 2020 08:16:54 -0500
Received: by mail-ed1-f47.google.com with SMTP id i16so22217879edr.5;
        Fri, 17 Jan 2020 05:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K4w84jeiEApmUAv8Ng6sqscsJyaqLN8PMcOEV7u7yIo=;
        b=UmjCtbJsHIGoMekKPv1NzzGEcItFtv6GcI3quaZ0PjbRuagedTAxOsS/j4VP7QC6Tp
         jjEpgbgDWvEb25m8uD7mKok96hXiMzDSMygXyjhEL3qUhjRcAkHrAVdCB/5alxW6Yoo1
         yPvuT1cg22BiD2AH4AEZL7JvT20wt4Jhqd+EtJvYdpvyz4Zz8KS+rtti13wyB7nATPh0
         aAwgHiP5DJewcB/S2nvgIwlXsYZdoGAjZNpPPEq4YQS6LV+ZyIkfl7Tfr/Q13agXCeF7
         xrN0xGVbpPOJMpvtfGbO2xXapaT3F8FTOld5ham5lZnZjWDpHARsPzakFEND1m8xVTHJ
         wYVQ==
X-Gm-Message-State: APjAAAVyOeZej4Ubah9UyW9KgARhdwmssxnq/XrqwwS0pEktkcA6J55j
        aikkC3j3hFKM9k1+xF8KtjU=
X-Google-Smtp-Source: APXvYqxWbvLzPyQZqTeV8ifBGGG07oZHO1XVI9xAEDNpfpSKgi/gsZVPzRRUfahqalmgL9dRIyFJlg==
X-Received: by 2002:aa7:cf81:: with SMTP id z1mr3582368edx.157.1579267012682;
        Fri, 17 Jan 2020 05:16:52 -0800 (PST)
Received: from pi3 ([194.230.155.229])
        by smtp.googlemail.com with ESMTPSA id dh4sm1052991edb.77.2020.01.17.05.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:16:51 -0800 (PST)
Date:   Fri, 17 Jan 2020 14:16:49 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Scott Mayhew <smayhew@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [BISECT BUG] NFS v4 root not working after 6d972518b821 ("NFS:
 Add fs_context support.")
Message-ID: <20200117131649.GA12406@pi3>
References: <CAJKOXPeCVwZfBsCVbc9RQUGi0UfWQw0uFamPiQasiO8fSthFsQ@mail.gmail.com>
 <365390.1579265674@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <365390.1579265674@warthog.procyon.org.uk>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 17, 2020 at 12:54:34PM +0000, David Howells wrote:
> Which git tree/branch are you using?
> 
> David

The report was from linux-next. The binary is from regular system Arch
Linux Arm... but now I wonder how did I get v3.1 as all my systems
recently have v2.4 or v2.3...

I can replace the binary with v2.4 and try again, although kernel should
probably not behave differently. So far it was working fine.

Best regards,
Krzysztof

