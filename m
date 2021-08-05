Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25993E1B28
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Aug 2021 20:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbhHESXs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Aug 2021 14:23:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235197AbhHESXr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Aug 2021 14:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628187812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LfDyC1k/Grs8TtzNPO0C4CGpOznJnU2PRON4TNFUu+M=;
        b=JNIeLJzm2MYpdOquUEFTvbcVn1++1WyM35xZogUvgRN6BwHQMP8b+3SQd4rcSGPl048NTb
        Myr3tNmplC1teeBzGewo1OCcd/htlFniMv5LWKa/DlLx79PbmmcWNH2aTZuHlnRk1lx8me
        7pdLMLnZgzPxCvUSpgSXmJWQWLQMdsk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-CwEsKgCDPqqI1fOSscz8bw-1; Thu, 05 Aug 2021 14:23:31 -0400
X-MC-Unique: CwEsKgCDPqqI1fOSscz8bw-1
Received: by mail-qk1-f200.google.com with SMTP id h5-20020a05620a0525b02903b861bec838so4721322qkh.7
        for <linux-nfs@vger.kernel.org>; Thu, 05 Aug 2021 11:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LfDyC1k/Grs8TtzNPO0C4CGpOznJnU2PRON4TNFUu+M=;
        b=TZEz0Vxc1hZ8Ihjhjkv1sfPZlPrz7pNKFx79kV18rd4cKY17e3kcLI2IEVA3TovCS+
         FPbDGL8eTBHl497UyiVlfdPwuJtPLFV2smiCYZhsNlxyZKF3Oksfq6W+YLeoe/kIIbgD
         sZZSWtp/T/byCkRrHk7aSiuawTTlKyE5dc2t8sTNLW7TuSwI233eMj8gWjlGWqGTXFHJ
         nTMjoZMrMVibQuz8ZMwP7JAUfeiP3vNqBzN7EXHlyACvQwjtA9y/HE9mgTVl7M4c2cNu
         uY7+KFx17/gN2Y8KFJ2KxX0YQVhCB83V7f2B3H5MMTtmn3VkKXc+yVyqvxp8EKrdMmnL
         divg==
X-Gm-Message-State: AOAM531GeRWDR1zz1jncDmY8opD2sjHucYf+P1v0MjJkilNA/bqwAXub
        clCXGDpISpcLS/voQ5LNnr8k1OihY8b4cphOQ6hFej7UDHt39Fcvx/GWSCROlLXuoAqfcbrZHz2
        rAVB1vBvxwkgQOg/rnzC4wJ+25KByKHCuN2CE2Fo9WGGGvQKh4TXBoJwxH6CTDKYdX47qSw==
X-Received: by 2002:a05:620a:16b0:: with SMTP id s16mr6202991qkj.289.1628187811014;
        Thu, 05 Aug 2021 11:23:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxY3aYlGf+NdgUqoggjSkEvbifmMGt2ztFHCKLEIVLyRIWmWI4e+Wu8ltGNc+Q8AI25/YxJ7w==
X-Received: by 2002:a05:620a:16b0:: with SMTP id s16mr6202966qkj.289.1628187810730;
        Thu, 05 Aug 2021 11:23:30 -0700 (PDT)
Received: from madhat.boston.devel.redhat.com ([70.109.164.82])
        by smtp.gmail.com with ESMTPSA id c68sm3582320qkf.48.2021.08.05.11.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 11:23:30 -0700 (PDT)
Subject: Re: [RFC PATCH] mount.nfs: Add readahead option
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "trbecker@gmail.com" <trbecker@gmail.com>
Cc:     "tbecker@redhat.com" <tbecker@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <20210803130717.2890565-1-trbecker@gmail.com>
 <6b627dc6ebc9ee1cbd37a62b48d08b1a031f0f08.camel@hammerspace.com>
From:   Steve Dickson <steved@redhat.com>
Message-ID: <b1f88c47-fe08-f0a2-ad3e-a65e0fa86874@redhat.com>
Date:   Thu, 5 Aug 2021 14:23:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6b627dc6ebc9ee1cbd37a62b48d08b1a031f0f08.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey Trond!

On 8/3/21 11:15 AM, Trond Myklebust wrote:
> On Tue, 2021-08-03 at 10:07 -0300, Thiago Rafael Becker wrote:
>> Linux kernel defined the default read ahead to 128KiB, and this is
>> making read perform poorly. To mitigate it, add readahead as a mount
>> option that is handled by userspace, with some refactoring included.
>>
>> Signed-off-by: Thiago Rafael Becker <trbecker@gmail.com>
>> ---
>>   utils/mount/mount.c | 114 ++++++++++++++++++++++++++++++++++++++++--
>> --
>>   utils/mount/nfs.man |   3 ++
>>   2 files changed, 108 insertions(+), 9 deletions(-)
>>
>> diff --git a/utils/mount/mount.c b/utils/mount/mount.c
>> index b98f9e00..15076ca8 100644
>> --- a/utils/mount/mount.c
>> +++ b/utils/mount/mount.c
>> @@ -56,9 +56,11 @@ int nomtab;
>>   int verbose;
>>   int sloppy;
>>   int string;
>> +static int readahead_kb = 0;
>>   
>>   #define FOREGROUND     (0)
>>   #define BACKGROUND     (1)
>> +#define READAHEAD_VALUE_LEN 24
>>   
>>   static struct option longopts[] = {
>>     { "fake", 0, 0, 'f' },
>> @@ -292,6 +294,16 @@ static int add_mtab(char *spec, char
>> *mount_point, char *fstype,
>>          return result;
>>   }
>>   
>> +static void append_extra_opt(const char *opt, char *extra_opts,
>> size_t len) {
>> +       len -= strlen(extra_opts);
>> +
>> +       if (*extra_opts && --len > 0)
>> +               strcat(extra_opts, ",");
>> +
>> +       if ((len -= strlen(opt)) > 0)
>> +               strcat(extra_opts, opt);
>> +}
>> +
>>   static void parse_opt(const char *opt, int *mask, char *extra_opts,
>> size_t len)
>>   {
>>          const struct opt_map *om;
>> @@ -306,13 +318,37 @@ static void parse_opt(const char *opt, int
>> *mask, char *extra_opts, size_t len)
>>                  }
>>          }
>>   
>> -       len -= strlen(extra_opts);
>> +       append_extra_opt(opt, extra_opts, len);
>> +}
>>   
>> -       if (*extra_opts && --len > 0)
>> -               strcat(extra_opts, ",");
>> +static void parse_opt_val(const char *opt, const char *val, char
>> *extra_opts, size_t len)
>> +{
>> +       size_t ov_len;
>> +       char *opt_val;
>>   
>> -       if ((len -= strlen(opt)) > 0)
>> -               strcat(extra_opts, opt);
>> +       /* readahead is a special value that is handled by userspace
>> */
>> +       if (!strcmp(opt,  "readahead")) {
>> +               char *endptr = NULL;
>> +               const char *expected_endptr = val + strlen(val);
>> +
>> +               readahead_kb = strtol(val, &endptr, 10);
>> +
>> +               if (endptr != expected_endptr) {
>> +                       nfs_error(_("%s: invalid readahead value
>> %s"),
>> +                                      progname, val);
>> +                       readahead_kb = 0;
>> +               }
>> +               return;
>> +       }
>> +
>> +       /* Send the option to the kernel. */
>> +       ov_len = strlen(opt) + strlen(val) + 3;
>> +       opt_val = malloc(sizeof(char) * ov_len);
>> +       snprintf(opt_val, ov_len, ",%s=%s", opt, val);
>> +
>> +       append_extra_opt(opt_val, extra_opts, len);
>> +
>> +       free(opt_val);
>>   }
>>   
>>   /*
>> @@ -325,7 +361,7 @@ static void parse_opts(const char *options, int
>> *flags, char **extra_opts)
>>   {
>>          if (options != NULL) {
>>                  char *opts = xstrdup(options);
>> -               char *opt, *p;
>> +               char *opt, *p, *val = NULL;
>>                  size_t len = strlen(opts) + 1;  /* include room for a
>> null */
>>                  int open_quote = 0;
>>   
>> @@ -341,17 +377,75 @@ static void parse_opts(const char *options, int
>> *flags, char **extra_opts)
>>                                  continue;       /* still in a quoted
>> block */
>>                          if (*p == ',')
>>                                  *p = '\0';      /* terminate the
>> option item */
>> +                       if (*p == '=') {        /* key=val option */
>> +                               if (!val) {
>> +                                       *p = '\0';      /* terminate
>> key */
>> +                                       val = ++p;      /* start the
>> value */
>> +                               }
>> +                       }
>>   
>>                          /* end of option item or last item */
>>                          if (*p == '\0' || *(p + 1) == '\0') {
>> -                               parse_opt(opt, flags, *extra_opts,
>> len);
>> -                               opt = NULL;
>> +                               if (val) {
>> +                                       parse_opt_val(opt, val,
>> *extra_opts, len);
>> +                               } else
>> +                                       parse_opt(opt, flags,
>> *extra_opts, len);
>> +                               opt = val = NULL;
>>                          }
>>                  }
>>                  free(opts);
>>          }
>>   }
>>   
>> +/*
>> + * Set the read ahead value for the mount point. On failure, uses
>> the default kernel
>> + * read ahead value (for new mounts) or the current value (for
>> remounts).
>> + */
>> +static void set_readahead(const char *mount_point) {
>> +       int error;
>> +       struct statx mp_stat;
>> +       char *mount_point_readahead_file, value[READAHEAD_VALUE_LEN];
>> +       size_t len;
>> +       int fp;
>> +
>> +       /* If readahead_kb is unset, or set to 0, do not change the
>> value */
>> +       if (!readahead_kb)
>> +               return;
>> +
>> +       if ((error = statx(0, mount_point, 0, 0, &mp_stat)) != 0) {
>> +               goto out_error;
>> +       }
>> +
>> +       if (!(mount_point_readahead_file = malloc(PATH_MAX))) {
>> +               error = -ENOMEM;
>> +               goto out_error;
>> +       }
>> +
>> +       snprintf(mount_point_readahead_file, PATH_MAX,
>> "/sys/class/bdi/%d:%d/read_ahead_kb",
>> +                       mp_stat.stx_dev_major,
>> mp_stat.stx_dev_minor);
>> +
>> +       len = snprintf(value, READAHEAD_VALUE_LEN, "%d",
>> readahead_kb);
>> +
>> +       if ((fp = open(mount_point_readahead_file, O_WRONLY)) < 0) {
>> +               error = errno;
>> +               goto out_free;
>> +       }
>> +
>> +       if ((error = write(fp, value, len)) < 0)
>> +               goto out_close;
>> +
>> +       close(fp);
>> +       return;
>> +
>> +out_close:
>> +       close(fp);
>> +out_free:
>> +       free(mount_point_readahead_file);
>> +out_error:
>> +       nfs_error(_("%s: unable to set readahead value, using default
>> kernel value (error = %d)\n"),
>> +                       progname, error);
>> +}
>> +
>>   static int try_mount(char *spec, char *mount_point, int flags,
>>                          char *fs_type, char **extra_opts, char
>> *mount_opts,
>>                          int fake, int bg)
>> @@ -373,8 +467,10 @@ static int try_mount(char *spec, char
>> *mount_point, int flags,
>>          if (ret)
>>                  return ret;
>>   
>> -       if (!fake)
>> +       if (!fake) {
>> +               set_readahead(mount_point);
>>                  print_one(spec, mount_point, fs_type, mount_opts);
>> +       }
>>   
>>          return add_mtab(spec, mount_point, fs_type, flags,
>> *extra_opts);
>>   }
>> diff --git a/utils/mount/nfs.man b/utils/mount/nfs.man
>> index f1b76936..9832a377 100644
>> --- a/utils/mount/nfs.man
>> +++ b/utils/mount/nfs.man
>> @@ -561,6 +561,9 @@ The
>>   .B sloppy
>>   option is an alternative to specifying
>>   .BR mount.nfs " -s " option.
>> +.TP 1.5i
>> +.B readahead=n
>> +Set the read ahead of the mount to n KiB. This is handled entirely
>> in userspace and will not appear on mountinfo. If unset or set to 0,
>> it will not set the a value, using the current value (for a remount)
>> or the kernel default for a new mount.
>>   
>>   .SS "Options for NFS versions 2 and 3 only"
>>   Use these options, along with the options in the above subsection,
> 
> 
> There is already a method for doing this: you set up an appropriate
> entry in /etc/udev/rules.d/. Adding a mount option, particularly one
> that is NFS only and is handled in userspace rather than by the kernel
> parser, just causes fragmentation and confusion.
> 
> If you want to help users configure readahead, I'd suggest focussing on
> a utility to help them set up the udev rule correctly.I'm leaning toward taking this patch... True one can add a udev rule,
but setting a mount option is much simpler and straightforward...
Plus with nfsmount.conf, it can be per fs,server,or global.

You know I am not a fan of taking new mount options, but I have
bugs open that show the degrading of read performance from one
release over another... If we can eliminate that degradation with an 
mount option... I really don't see a problem with that...

steved.

