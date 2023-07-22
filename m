Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2556275DB35
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jul 2023 11:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjGVJHI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Jul 2023 05:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGVJHH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 22 Jul 2023 05:07:07 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBCC26A5
        for <linux-nfs@vger.kernel.org>; Sat, 22 Jul 2023 02:07:01 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d066d72eb12so1126172276.1
        for <linux-nfs@vger.kernel.org>; Sat, 22 Jul 2023 02:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google; t=1690016820; x=1690621620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L82SyP+OM7yBSxK6OvxnCttJ/Q4kkGB2zQhJAg0Rh6I=;
        b=OWVC6qZZiVlX2/oBO802Sv/JRugJQFG8RMvo+C2BuLCvt2Q3ydacElH5z1AZHFT7zA
         ocN/HmIZTAihpSlGVNnsRl3vCPOgz+LwHjDmjHO7x+XnhpEizVwJXeSxf0K14lvyJAEZ
         HFtjIQkTEjNg6jn68nO4McDEgWk5pejBx2VW1UJvQN0DcWS4a2zKQnMTFtG+L/9Fg7Zj
         tZxI8SjfP+wckCWri1tD4Pp98QMn2rwFKVOsXikURBa4u7eRicgJUhBzRQ97+26993Td
         af3E2LSD2mz+FChsvld0g/PpmMbZ3kbdSUK8zIJYO21t8QrFJ4aodTtvhyfaDfZCwQ0e
         fxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690016820; x=1690621620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L82SyP+OM7yBSxK6OvxnCttJ/Q4kkGB2zQhJAg0Rh6I=;
        b=aGw7qBuWogmGEwLeIPI4yfpKZLeUrQ4xK9CW5UUHtbeBmusCPgB3FwsAodesYDXWom
         fhzbOxIyf9RRPMMUdGMglpLCDkiBdo5HWD4jzkYni41vMHdSS/B09sS+P/rO+LuRXYq8
         huAueiytysgqIuz4rMHtIwJ+kavVbAYdTHNPqK7D3lfD0VcCGlz1FtiNXh4EMLyQg0QR
         m80uKKX7RZ8TDl8siyq8uH22M/0i4VL66nI7yzYgLr3FT4Slj2OXtsTWNwZ0EFFCN5rz
         UnFlftTkoNbfmvbUFITjhMZBYDhHFJCM3+lF6iZt/9DAvHnXPzdbAZQC74ucHH72t55l
         ZWBA==
X-Gm-Message-State: ABy/qLaBBUbyi36bd8Ki7ErKZLpZUk4pcxpklIrptWzncBn+SpY4dw3M
        ReBvlP4O/jKE+ipFfZK3OnqPdV8bbKPzDUkwK0mRouaDIqUaSRlJmZo=
X-Google-Smtp-Source: APBJJlHIZ/yMUp/UmzYm3h62MD/oktt0B+18Zf+qY13uhMTnotrTWqFqa6KJJ24bTKW7ULcO0hJJAYrDSawKVPhVNR4=
X-Received: by 2002:a25:2bc1:0:b0:ceb:e247:4f13 with SMTP id
 r184-20020a252bc1000000b00cebe2474f13mr10001453ybr.26.1690016820605; Sat, 22
 Jul 2023 02:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230721224530.I6e45%lars@pixar.com>
In-Reply-To: <20230721224530.I6e45%lars@pixar.com>
From:   Daire Byrne <daire@dneg.com>
Date:   Sat, 22 Jul 2023 10:06:24 +0100
Message-ID: <CAPt2mGPftexWtHqpRK+umg+w8QiAkGiTWA1wO1oBRYznDw-nUw@mail.gmail.com>
Subject: Re: Best kernel function to probe for NFS write accounting?
To:     lars@pixar.com
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On a related note, I have always wondered if there was any interest in
having something like the /proc/PID/io just for tracking NFS client
throughput?

The problem is that if you copy a file from NFS to a local filesystem,
there is no way to infer whether a process did a NFS read/write (or
any NFS IO at all).

It is useful to track per PID network IO and things like cgroups (v1)
do not provide an easy way to do that. In our case, 99.9% of all
network IO a render blade does is NFS client traffic.

To your question, I can't say what the BPF equivalent is, but we used
systemtap to track per process and per file IO on each render node.
However, again we are only interested in IO that results in actual
network packets so we needed to account for reads from page cache too.

We did it by watching vfs.add_to_page_cache and naively assuming every
hit resulted in 4k of network NFS reads. In this way we infer that the
read comes over the network as it's not in the page cache yet. The
aggregate from all clients matched the network of our NFS servers
pretty well so this approach worked for us. We could track all client
file IO and correlate it with what the server was doing over the
network.

The systemtap code was something like the following where files were
tracked by nfs.fop.open:

        probe nfs.fop.open {
          pid = pid()
          filename = sprintf("%s", d_path(&\$filp->f_path))
          if (filename =~ "/net/.*/data") {
            files[pid, ino] = filename
            if ( !([pid, ino] in procinfo))
              procinfo[pid, ino] = sprintf("%s", proc())
          }
        }
        probe vfs.add_to_page_cache {
          pid = pid()
          if ([pid, ino] in files ) {
            readpage[pid, ino] += 4096
            files_store[pid, ino] = sprintf("%s", files[pid, ino])
          }
        }

But I should say that this no longer works in newer kernels since the
addition of folios and I have not figured out a better way to track
NFS client reads while excluding the page cache results.

For the writes I was just using vfs.write and vfs.writev - I was not
too concerned about writeback delays.

       probe vfs.write {
          pid = pid()
          if ([pid, ino] in files) {
            write[pid, ino] += bytes_to_write
            files_store[pid, ino] = sprintf("%s", files[pid, ino])
          }
        }

I hope that helps. Being from the same industry, we obviously have
similar requirements... ;)

Daire

On Fri, 21 Jul 2023 at 23:46, <lars@pixar.com> wrote:
>
> Hello,
>
> I'm using BPF to do NFS operation accounting for user-space processes. I'd like
> to include the number of bytes read and written to each file any processes open
> over NFS.
>
> For write operations, I'm currently using an fexit probe on the
> nfs_writeback_done function, and my program appears to be getting the
> information I'm hoping for. But I can see that under some circumstances the
> actual operations are being done by kworker threads, and so the PID reported by
> the BPF program is for that kworker instead of the user-space process that
> requested the write.
>
> Is there a more appropriate function to probe for this information if I only
> want it triggered in context of the user-space process that performed the
> write? If not, I'm wondering if there's enough information in a probe triggered
> in the kworker context to track down the user-space PID that initiated the
> writes.
>
> I didn't find anything related in the kernel's Documentation directory, and I'm
> not yet proficient enough with the vfs, nfs, and sunrpc code to find an
> appropriate function myself.
>
> If it matters, our infrastructure is all based on NFSv3.
>
> Thanks for any leads or documentation pointers!
> Lars
