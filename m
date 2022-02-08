Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8764AE4F3
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 23:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiBHWw1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 17:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiBHWwH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 17:52:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07D92E047DBB
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 14:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644359959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UcWvpzgKOa2AZ9x9Fz7SMjn5VOucDNOY/N3oq0Yfyzs=;
        b=L/G3o3vm/rFDaaCe/rYHGWyhsqnmeDCxreQfS5RPPMo2QaTf3btqba+Mr7bj/2tHMZH/wR
        sGQRhKBjSvY+sBai7z42wJnYaCCBPJHEQsCcWVMGvJIa2iyDJ68AXsEJS0SR6g2g4GHmTi
        JA4tY8fXawOVo2yDHYZaElTj8e0UAEg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-UK5iX9PxMjegVyTe1EJ1sQ-1; Tue, 08 Feb 2022 17:39:18 -0500
X-MC-Unique: UK5iX9PxMjegVyTe1EJ1sQ-1
Received: by mail-qk1-f198.google.com with SMTP id b18-20020a05620a089200b004e0e2f73f35so171760qka.19
        for <linux-nfs@vger.kernel.org>; Tue, 08 Feb 2022 14:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UcWvpzgKOa2AZ9x9Fz7SMjn5VOucDNOY/N3oq0Yfyzs=;
        b=NMAmfMCNwtlWupmPt8stY9a8QYrI4nQhnPnWDlm4LmUDr3Itgo2VpOIqGs0UimMtvf
         u89QgtFRzZR3Rz+ZvuxFsVY6tRLTkoCKQbwWS2oC6louUKxDJuZ1d4v4fiVQIChyHd0N
         6hjSx5Eiy+geR2Bj7Jq9XqNesF7Ea5hiMc1JVwVkREuU2VGPucJhfEBq6+Y5wFiHhOTg
         OBGxtwW2Usmm1tNFE3KtoQw/v93JHYSrh89h+BnTSJZugwO3rWFZEf6nyLymrWAtb+fD
         3xxrlKILTWcCPd7FM9oZr6nCPM03HrD6+5OPwkUEoGs2JIZv3QkoJ2Rr094m4xMnH6N/
         LBQg==
X-Gm-Message-State: AOAM531Vdsdtbqf9E8xC4cMUIoNx5J2fOejjBB1eeC+k4aTB2gj5dr7r
        i/ilWKZoAHPGMCOBSHxsp3Mlos8bbNLV9c0TBNvylJ5WqtF3t/IzDmixB/NMPLMno2UeCdufJge
        NIoL872WFTvtH5m1rYT6i
X-Received: by 2002:a05:6214:1cc7:: with SMTP id g7mr4878167qvd.124.1644359958124;
        Tue, 08 Feb 2022 14:39:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTINJoaGlgCF8XI0Q28L6sw1rVu5hjdOrTxe5512xKTeLDZ7qkRgdcdi3jLPxI21MnTFiEeg==
X-Received: by 2002:a05:6214:1cc7:: with SMTP id g7mr4878159qvd.124.1644359957662;
        Tue, 08 Feb 2022 14:39:17 -0800 (PST)
Received: from [172.31.1.6] ([70.105.253.180])
        by smtp.gmail.com with ESMTPSA id x13sm8027428qko.114.2022.02.08.14.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 14:39:17 -0800 (PST)
Message-ID: <281b1976-9b40-fc53-301a-2846c2ead5aa@redhat.com>
Date:   Tue, 8 Feb 2022 17:39:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <c2e8b7c06352d3cad3454de096024fff80e638af.1643979161.git.bcodding@redhat.com>
 <6f01c382-8da5-5673-30db-0c0099d820b5@redhat.com>
 <33B10EBB-3DD1-45FE-B7D2-D5EA21DFB172@oracle.com>
 <839b09ed-fd21-bda1-0502-d7c6f1fa9e88@redhat.com>
 <32D8EBC9-652A-49D7-B763-A82E2AEF6282@oracle.com>
From:   Steve Dickson <steved@redhat.com>
In-Reply-To: <32D8EBC9-652A-49D7-B763-A82E2AEF6282@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 2/8/22 4:18 PM, Chuck Lever III wrote:
> 
> 
>> On Feb 8, 2022, at 2:29 PM, Steve Dickson <steved@redhat.com> wrote:
>>
>>
>>
>> On 2/8/22 11:21 AM, Chuck Lever III wrote:
>>>> On Feb 8, 2022, at 11:04 AM, Steve Dickson <steved@redhat.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> On 2/4/22 7:56 AM, Benjamin Coddington wrote:
>>>>> The nfs4id program will either create a new UUID from a random source or
>>>>> derive it from /etc/machine-id, else it returns a UUID that has already
>>>>> been written to /etc/nfs4-id.  This small, lightweight tool is suitable for
>>>>> execution by systemd-udev in rules to populate the nfs4 client uniquifier.
>>>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>>>> ---
>>>>>   .gitignore               |   1 +
>>>>>   configure.ac             |   4 +
>>>>>   tools/Makefile.am        |   1 +
>>>>>   tools/nfs4id/Makefile.am |   8 ++
>>>>>   tools/nfs4id/nfs4id.c    | 184 +++++++++++++++++++++++++++++++++++++++
>>>>>   tools/nfs4id/nfs4id.man  |  29 ++++++
>>>>>   6 files changed, 227 insertions(+)
>>>>>   create mode 100644 tools/nfs4id/Makefile.am
>>>>>   create mode 100644 tools/nfs4id/nfs4id.c
>>>>>   create mode 100644 tools/nfs4id/nfs4id.man
>>>> Just a nit... naming convention... In the past
>>>> we never put the protocol version in the name.
>>>> Do a ls tools and utils directory and you
>>>> see what I mean....
>>>>
>>>> Would it be a problem to change the name from
>>>> nfs4id to nfsid?
>>> nfs4id is pretty generic, too.
>>> Can we go with nfs-client-id ?
>> I'm never been big with putting '-'
>> in command names... nfscltid would
>> be better IMHO... if we actually
>> need the 'clt' in the name.
> 
> We have nfsidmap already. IMO we need some distinction
> with user ID mapping tools... and some day we might
> want to manage server IDs too (see EXCHANGE_ID).
Hmm... So we could not use the same tool to do
both the server and client, via flags?

> 
> nfsclientid then?
You like to type more than I do... You always have... :-)

But like I started the conversation... the naming is
a nit... but I would like to see one tool to set the
ids for both the server and client... how about
nfsid -s and nfsid -c

steved.
> 
> 
>> steved.
>>
>>>> steved.
>>>>
>>>>> diff --git a/.gitignore b/.gitignore
>>>>> index c89d1cd2583d..a37964148dd8 100644
>>>>> --- a/.gitignore
>>>>> +++ b/.gitignore
>>>>> @@ -61,6 +61,7 @@ utils/statd/statd
>>>>>   tools/locktest/testlk
>>>>>   tools/getiversion/getiversion
>>>>>   tools/nfsconf/nfsconf
>>>>> +tools/nfs4id/nfs4id
>>>>>   support/export/mount.h
>>>>>   support/export/mount_clnt.c
>>>>>   support/export/mount_xdr.c
>>>>> diff --git a/configure.ac b/configure.ac
>>>>> index 50e9b321dcf3..93d0a902cfd8 100644
>>>>> --- a/configure.ac
>>>>> +++ b/configure.ac
>>>>> @@ -355,6 +355,9 @@ if test "$enable_nfsv4" = yes; then
>>>>>     dnl check for the keyutils libraries and headers
>>>>>     AC_KEYUTILS
>>>>>   +  dnl check for the libuuid library and headers
>>>>> +  AC_LIBUUID
>>>>> +
>>>>>     dnl Check for sqlite3
>>>>>     AC_SQLITE3_VERS
>>>>>   @@ -740,6 +743,7 @@ AC_CONFIG_FILES([
>>>>>   	tools/nfsdclnts/Makefile
>>>>>   	tools/nfsconf/Makefile
>>>>>   	tools/nfsdclddb/Makefile
>>>>> +	tools/nfs4id/Makefile
>>>>>   	utils/Makefile
>>>>>   	utils/blkmapd/Makefile
>>>>>   	utils/nfsdcld/Makefile
>>>>> diff --git a/tools/Makefile.am b/tools/Makefile.am
>>>>> index 9b4b0803db39..cc658f69bb32 100644
>>>>> --- a/tools/Makefile.am
>>>>> +++ b/tools/Makefile.am
>>>>> @@ -7,6 +7,7 @@ OPTDIRS += rpcgen
>>>>>   endif
>>>>>     OPTDIRS += nfsconf
>>>>> +OPTDIRS += nfs4id
>>>>>     if CONFIG_NFSDCLD
>>>>>   OPTDIRS += nfsdclddb
>>>>> diff --git a/tools/nfs4id/Makefile.am b/tools/nfs4id/Makefile.am
>>>>> new file mode 100644
>>>>> index 000000000000..d1e60a35a510
>>>>> --- /dev/null
>>>>> +++ b/tools/nfs4id/Makefile.am
>>>>> @@ -0,0 +1,8 @@
>>>>> +## Process this file with automake to produce Makefile.in
>>>>> +
>>>>> +man8_MANS	= nfs4id.man
>>>>> +
>>>>> +bin_PROGRAMS = nfs4id
>>>>> +
>>>>> +nfs4id_SOURCES = nfs4id.c
>>>>> +nfs4id_LDADD = $(LIBUUID)
>>>>> diff --git a/tools/nfs4id/nfs4id.c b/tools/nfs4id/nfs4id.c
>>>>> new file mode 100644
>>>>> index 000000000000..dbb807ae21f3
>>>>> --- /dev/null
>>>>> +++ b/tools/nfs4id/nfs4id.c
>>>>> @@ -0,0 +1,184 @@
>>>>> +/*
>>>>> + * nfs4id.c -- create and persist uniquifiers for nfs4 clients
>>>>> + *
>>>>> + * Copyright (C) 2022  Red Hat, Benjamin Coddington <bcodding@redhat.com>
>>>>> + *
>>>>> + * This program is free software; you can redistribute it and/or
>>>>> + * modify it under the terms of the GNU General Public License
>>>>> + * as published by the Free Software Foundation; either version 2
>>>>> + * of the License, or (at your option) any later version.
>>>>> + *
>>>>> + * This program is distributed in the hope that it will be useful,
>>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>>> + * GNU General Public License for more details.
>>>>> + *
>>>>> + * You should have received a copy of the GNU General Public License
>>>>> + * along with this program; if not, write to the Free Software
>>>>> + * Foundation, Inc., 51 Franklin Street, Fifth Floor,
>>>>> + * Boston, MA 02110-1301, USA.
>>>>> + */
>>>>> +
>>>>> +#include <stdio.h>
>>>>> +#include <stdarg.h>
>>>>> +#include <getopt.h>
>>>>> +#include <string.h>
>>>>> +#include <errno.h>
>>>>> +#include <stdlib.h>
>>>>> +#include <fcntl.h>
>>>>> +#include <unistd.h>
>>>>> +#include <uuid/uuid.h>
>>>>> +
>>>>> +#define NFS4IDFILE "/etc/nfs4-id"
>>>>> +
>>>>> +UUID_DEFINE(nfs4_clientid_uuid_template,
>>>>> +	0xa2, 0x25, 0x68, 0xb2, 0x7a, 0x5f, 0x49, 0x90,
>>>>> +	0x8f, 0x98, 0xc5, 0xf0, 0x67, 0x78, 0xcc, 0xf1);
>>>>> +
>>>>> +static char *prog;
>>>>> +static char *source = NULL;
>>>>> +static char nfs4_id[64];
>>>>> +static int force = 0;
>>>>> +
>>>>> +static void usage(void)
>>>>> +{
>>>>> +	fprintf(stderr, "usage: %s [-f|--force] [machine]\n", prog);
>>>>> +}
>>>>> +
>>>>> +static void fatal(const char *fmt, ...)
>>>>> +{
>>>>> +	int err = errno;
>>>>> +	va_list args;
>>>>> +	char fatal_msg[256] = "fatal: ";
>>>>> +
>>>>> +	va_start(args, fmt);
>>>>> +	vsnprintf(&fatal_msg[7], 255, fmt, args);
>>>>> +	if (err)
>>>>> +		fprintf(stderr, "%s: %s\n", fatal_msg, strerror(err));
>>>>> +	else
>>>>> +		fprintf(stderr, "%s\n", fatal_msg);
>>>>> +	exit(-1);
>>>>> +}
>>>>> +
>>>>> +static int read_nfs4_id(void)
>>>>> +{
>>>>> +	int fd;
>>>>> +
>>>>> +	fd = open(NFS4IDFILE, O_RDONLY);
>>>>> +	if (fd < 0)
>>>>> +		return fd;
>>>>> +	read(fd, nfs4_id, 64);
>>>>> +	close(fd);
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>> +static void write_nfs4_id(void)
>>>>> +{
>>>>> +	int fd;
>>>>> +
>>>>> +	fd = open(NFS4IDFILE, O_RDWR|O_TRUNC|O_CREAT, S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH);
>>>>> +	if (fd < 0)
>>>>> +		fatal("could not write id to " NFS4IDFILE);
>>>>> +	write(fd, nfs4_id, 37);
>>>>> +}
>>>>> +
>>>>> +static void print_nfs4_id(void)
>>>>> +{
>>>>> +	fprintf(stdout, "%s", nfs4_id);
>>>>> +}
>>>>> +	
>>>>> +static void check_or_make_id(void)
>>>>> +{
>>>>> +	int ret;
>>>>> +	uuid_t nfs4id_uuid;
>>>>> +
>>>>> +	ret = read_nfs4_id();
>>>>> +	if (ret != 0) {
>>>>> +		if (errno != ENOENT )
>>>>> +			fatal("reading file " NFS4IDFILE);
>>>>> +		uuid_generate_random(nfs4id_uuid);
>>>>> +		uuid_unparse(nfs4id_uuid, nfs4_id);
>>>>> +		nfs4_id[36] = '\n';
>>>>> +		nfs4_id[37] = '\0';
>>>>> +		write_nfs4_id();
>>>>> +	}
>>>>> +	print_nfs4_id();	
>>>>> +}
>>>>> +
>>>>> +static void check_or_make_id_from_machine(void)
>>>>> +{
>>>>> +	int fd, ret;
>>>>> +	char machineid[32];
>>>>> +	uuid_t nfs4id_uuid;
>>>>> +
>>>>> +	ret = read_nfs4_id();
>>>>> +	if (ret != 0) {
>>>>> +		if (errno != ENOENT )
>>>>> +			fatal("reading file " NFS4IDFILE);
>>>>> +
>>>>> +		fd = open("/etc/machine-id", O_RDONLY);
>>>>> +		if (fd < 0)
>>>>> +			fatal("unable to read /etc/machine-id");
>>>>> +
>>>>> +		read(fd, machineid, 32);
>>>>> +		close(fd);
>>>>> +
>>>>> +		uuid_generate_sha1(nfs4id_uuid, nfs4_clientid_uuid_template, machineid, 32);
>>>>> +		uuid_unparse(nfs4id_uuid, nfs4_id);
>>>>> +		nfs4_id[36] = '\n';
>>>>> +		nfs4_id[37] = '\0';
>>>>> +		write_nfs4_id();
>>>>> +	}
>>>>> +	print_nfs4_id();
>>>>> +}
>>>>> +
>>>>> +int main(int argc, char **argv)
>>>>> +{
>>>>> +	prog = argv[0];
>>>>> +
>>>>> +	while (1) {
>>>>> +		int opt;
>>>>> +		int option_index = 0;
>>>>> +		static struct option long_options[] = {
>>>>> +			{"force",	no_argument,	0, 'f' },
>>>>> +			{0,			0,				0, 0 }
>>>>> +		};
>>>>> +
>>>>> +		errno = 0;
>>>>> +		opt = getopt_long(argc, argv, ":f", long_options, &option_index);
>>>>> +		if (opt == -1)
>>>>> +			break;
>>>>> +
>>>>> +		switch (opt) {
>>>>> +		case 'f':
>>>>> +			force = 1;
>>>>> +			break;
>>>>> +		case '?':
>>>>> +			usage();
>>>>> +			fatal("unexpected arg \"%s\"", argv[optind - 1]);
>>>>> +			break;
>>>>> +		}
>>>>> +	}
>>>>> +
>>>>> +	argc -= optind;
>>>>> +
>>>>> +	if (argc > 1) {
>>>>> +		usage();
>>>>> +		fatal("Too many arguments");
>>>>> +	}
>>>>> +
>>>>> +	if (argc)
>>>>> +		source = argv[optind++];
>>>>> +
>>>>> +	if (force)
>>>>> +		unlink(NFS4IDFILE);
>>>>> +
>>>>> +	if (!source)
>>>>> +		check_or_make_id();
>>>>> +	else if (strcmp(source, "machine") == 0)
>>>>> +		check_or_make_id_from_machine();
>>>>> +	else {
>>>>> +		usage();
>>>>> +		fatal("unrecognized source %s\n", source);
>>>>> +	}
>>>>> +}
>>>>> diff --git a/tools/nfs4id/nfs4id.man b/tools/nfs4id/nfs4id.man
>>>>> new file mode 100644
>>>>> index 000000000000..358f836468a2
>>>>> --- /dev/null
>>>>> +++ b/tools/nfs4id/nfs4id.man
>>>>> @@ -0,0 +1,29 @@
>>>>> +.\"
>>>>> +.\" nfs4id(8)
>>>>> +.\"
>>>>> +.TH nfs4id 8 "3 Feb 2022"
>>>>> +.SH NAME
>>>>> +nfs4id \- Generate or return nfs4 client id uniqueifiers
>>>>> +.SH SYNOPSIS
>>>>> +.B nfs4id [ -f | --force ] [<source>]
>>>>> +
>>>>> +.SH DESCRIPTION
>>>>> +The
>>>>> +.B nfs4id
>>>>> +command provides a simple utility to help NFS Version 4 clients use unique
>>>>> +and persistent client id values.  The command checks for the existence of a
>>>>> +file /etc/nfs4-id and returns the first 64 chars read from that file.  If
>>>>> +the file is not found, a UUID is generated from the specified source and
>>>>> +written to the file and returned.
>>>>> +.SH OPTIONS
>>>>> +.TP
>>>>> +.BR \-f, \-\-force
>>>>> +Overwrite the existing /etc/nfs4-id with a UUID generated from <source>.
>>>>> +.SH Sources
>>>>> +If <source> is not specified, nfs4id will generate a new random UUID.
>>>>> +
>>>>> +If <source> is "machine", nfs4id will generate a deterministic UUID value
>>>>> +derived from a sha1 hash of the contents of /etc/machine-id and a static
>>>>> +key.
>>>>> +.SH SEE ALSO
>>>>> +.BR machine-id (5)
>>> --
>>> Chuck Lever
>>
> 
> --
> Chuck Lever
> 
> 
> 

