Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE271ED2CE
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2020 16:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgFCO6A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 3 Jun 2020 10:58:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35226 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgFCO6A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Jun 2020 10:58:00 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-62gS6p8mMHKoGBxfzQG9qw-1; Wed, 03 Jun 2020 10:57:57 -0400
X-MC-Unique: 62gS6p8mMHKoGBxfzQG9qw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3678264AD4
        for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2020 14:57:56 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-114-183.rdu2.redhat.com [10.10.114.183])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1949B78F15;
        Wed,  3 Jun 2020 14:57:56 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 4AE4B1A00CC; Wed,  3 Jun 2020 10:57:55 -0400 (EDT)
Date:   Wed, 3 Jun 2020 10:57:55 -0400
From:   Scott Mayhew <smayhew@redhat.com>
To:     Rohan Sable <rsable@redhat.com>
Cc:     linux-nfs@vger.kernel.org, steved@redhat.com
Subject: Re: [PATCH] mountstats: Adding Day:Hour:Min:Sec format along with
 age to "mountstats --raw" for ease of understanding.
Message-ID: <20200603145755.GF108002@aion.usersys.redhat.com>
References: <20200602092919.GA42177@fedora.rsable.com>
MIME-Version: 1.0
In-Reply-To: <20200602092919.GA42177@fedora.rsable.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aion.usersys.redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Rohan,

On Tue, 02 Jun 2020, Rohan Sable wrote:

> The output will look something like this :
> 
> From :
> age:    2215
> 
> To   :
> age:    2267; 0 Day(s) 0 Hour(s) 37 Min(s) 47 Sec(s)
> 
> Signed-off-by: Rohan Sable <rsable@redhat.com>
> ---
>  tools/mountstats/mountstats.py | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
> index 6ac83ccb..d9b5af1b 100755
> --- a/tools/mountstats/mountstats.py
> +++ b/tools/mountstats/mountstats.py
> @@ -228,6 +228,15 @@ Nfsv4ops = [
>      'CLONE'
>  ]
>  
> +def sec_conv(rem):
> +    day = int(rem / (24 * 3600))
> +    rem %= (24 * 3600)
> +    hrs = int(rem / 3600)
> +    rem %= 3600
> +    min = int(rem / 60)
> +    sec = rem % 60
> +    print(day, "Day(s)", hrs, "Hour(s)", min, "Min(s)", sec, "Sec(s)")
> +
>  class DeviceData:
>      """DeviceData objects provide methods for parsing and displaying
>      data for a single mount grabbed from /proc/self/mountstats
> @@ -349,7 +358,8 @@ class DeviceData:
>              (self.__nfs_data['export'], self.__nfs_data['mountpoint'], \
>              self.__nfs_data['fstype'], self.__nfs_data['statvers']))
>          print('\topts:\t%s' % ','.join(self.__nfs_data['mountoptions']))
> -        print('\tage:\t%d' % self.__nfs_data['age'])
> +        print('\tage:\t%d' % self.__nfs_data['age'], end="; ")
> +        sec_conv(self.__nfs_data['age'])

If you write this raw output to a file, you can no longer use the
resulting file with 'mountstats --file' or 'mountstats --since':

[smayhew@aion nfs-utils]$ tools/mountstats/mountstats.py --file b1 --since a1
Traceback (most recent call last):
  File "tools/mountstats/mountstats.py", line 1130, in <module>
    res = main()
  File "tools/mountstats/mountstats.py", line 1119, in main
    return args.func(args)
  File "tools/mountstats/mountstats.py", line 846, in mountstats_command
    stats.parse_stats(descr)
  File "tools/mountstats/mountstats.py", line 333, in parse_stats
    self.__parse_nfs_line(words)
  File "tools/mountstats/mountstats.py", line 263, in __parse_nfs_line
    self.__nfs_data['age'] = int(words[1])
ValueError: invalid literal for int() with base 10: '366;'


That was the original intended purpose for the raw option.

I think it would be better leave display_raw_stats() alone and either
add the age (including the call to sec_conv()) to display_stats_header()
(in which case it would always appear except for when the --raw option
is used), or add it to display_nfs_options() (in which case it would
only be shown when mountstats is invoked with no options or with the
--nfs option).

-Scott

>          print('\tcaps:\t%s' % ','.join(self.__nfs_data['servercapabilities']))
>          print('\tsec:\tflavor=%d,pseudoflavor=%d' % (self.__nfs_data['flavor'], \
>              self.__nfs_data['pseudoflavor']))
> -- 
> 2.25.4
> 

