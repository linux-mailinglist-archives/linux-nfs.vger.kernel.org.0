Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88D11D7FCD
	for <lists+linux-nfs@lfdr.de>; Mon, 18 May 2020 19:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgERRO4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 18 May 2020 13:14:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20822 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727006AbgERRO4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 18 May 2020 13:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589822093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m/CpDK3z7+CTC6dK1CoWGTA2EKrJqHTuzbxf7BedJ/Y=;
        b=Sfl8fmPs7HgxEV5avWUNRRF+ETfc0eHeCB/aAF3HBZAjtnXP0rtHQutRQIqOsoUbwShFbM
        hJ7NZyci0jWLbApNYoLJDpLVdc/PTywCHRCb2bcFlF9an2aSu2dwy6ZXBBZqcpCBdE6Yot
        pBdaQk540S6XtMrYQUfk9Jt0me6E1k4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-wS6t6LtsN_u_DIKeFZuzZQ-1; Mon, 18 May 2020 13:14:36 -0400
X-MC-Unique: wS6t6LtsN_u_DIKeFZuzZQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1402819057A3
        for <linux-nfs@vger.kernel.org>; Mon, 18 May 2020 17:14:36 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-189.phx2.redhat.com [10.3.113.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B25E264441
        for <linux-nfs@vger.kernel.org>; Mon, 18 May 2020 17:14:35 +0000 (UTC)
Subject: Re: [PATCH V3 1/2] nfs-utils: add new tool nfsdclts to parse output
 from proc files
To:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20200518141050.74702-1-steved@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <7af8755a-b618-a8d8-f18c-9896c67bc7a5@RedHat.com>
Date:   Mon, 18 May 2020 13:14:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518141050.74702-1-steved@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/18/20 10:10 AM, Steve Dickson wrote:
> From: Achilles Gaikwad <agaikwad@redhat.com>
> 
> This tool parses the output from the following files
> 
>  /proc/fs/nfsd/clients/*/{states,info}
> 
> Signed-off-by: Achilles Gaikwad <agaikwad@redhat.com>
> Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
> Signed-off-by: Steve Dickson <steved@redhat.com>
Committed (tag: nfs-utils-2-4-4-rc5)

steved.
> ---
>  configure.ac                 |   1 +
>  tools/Makefile.am            |   2 +-
>  tools/nfsdclnts/Makefile.am  |   9 ++
>  tools/nfsdclnts/nfsdclnts.py | 221 +++++++++++++++++++++++++++++++++++
>  4 files changed, 232 insertions(+), 1 deletion(-)
>  create mode 100644 tools/nfsdclnts/Makefile.am
>  create mode 100755 tools/nfsdclnts/nfsdclnts.py
> 
> v3: rename command to nfsdclnts 
> 
> diff --git a/configure.ac b/configure.ac
> index 0b1c8cc..9631278 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -694,6 +694,7 @@ AC_CONFIG_FILES([
>  	tools/rpcgen/Makefile
>  	tools/mountstats/Makefile
>  	tools/nfs-iostat/Makefile
> +	tools/nfsdclnts/Makefile
>  	tools/nfsconf/Makefile
>  	tools/nfsdclddb/Makefile
>  	utils/Makefile
> diff --git a/tools/Makefile.am b/tools/Makefile.am
> index 432d35d..9b4b080 100644
> --- a/tools/Makefile.am
> +++ b/tools/Makefile.am
> @@ -12,6 +12,6 @@ if CONFIG_NFSDCLD
>  OPTDIRS += nfsdclddb
>  endif
>  
> -SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat $(OPTDIRS)
> +SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat nfsdclnts $(OPTDIRS)
>  
>  MAINTAINERCLEANFILES = Makefile.in
> diff --git a/tools/nfsdclnts/Makefile.am b/tools/nfsdclnts/Makefile.am
> new file mode 100644
> index 0000000..c1f12a0
> --- /dev/null
> +++ b/tools/nfsdclnts/Makefile.am
> @@ -0,0 +1,9 @@
> +## Process this file with automake to produce Makefile.in
> +PYTHON_FILES = nfsdclnts.py
> +
> +all-local: $(PYTHON_FILES)
> +
> +install-data-hook:
> +	$(INSTALL) -m 755 nfsdclnts.py $(DESTDIR)$(sbindir)/nfsdclnts
> +
> +MAINTAINERCLEANFILES=Makefile.in
> diff --git a/tools/nfsdclnts/nfsdclnts.py b/tools/nfsdclnts/nfsdclnts.py
> new file mode 100755
> index 0000000..2d0ad0a
> --- /dev/null
> +++ b/tools/nfsdclnts/nfsdclnts.py
> @@ -0,0 +1,221 @@
> +#!/bin/python3
> +# -*- python-mode -*-
> +'''
> +    Copyright (C) 2020
> +    Authors:    Achilles Gaikwad <agaikwad@redhat.com>
> +                Kenneth  D'souza <kdsouza@redhat.com>
> +
> +    This program is free software: you can redistribute it and/or modify
> +    it under the terms of the GNU General Public License as published by
> +    the Free Software Foundation, either version 3 of the License, or
> +    (at your option) any later version.
> +
> +    This program is distributed in the hope that it will be useful,
> +    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +    GNU General Public License for more details.
> +
> +    You should have received a copy of the GNU General Public License
> +    along with this program.  If not, see <https://www.gnu.org/licenses/>.
> +'''
> +
> +import multiprocessing as mp
> +import os
> +import signal
> +import sys
> +
> +try:
> +    import argparse
> +except ImportError:
> +    print('%s:  Failed to import argparse - make sure argparse is installed!'
> +        % sys.argv[0])
> +    sys.exit(1)
> +try:
> +    import yaml
> +except ImportError:
> +    print('%s:  Failed to import yaml - make sure python3-pyyaml is installed!'
> +        % sys.argv[0])
> +    sys.exit(1)
> +
> +BBOLD = '\033[1;30;47m' #Bold black text with white background.
> +ENDC = '\033[m' #Rest to defaults
> +
> +def init_worker():
> +    signal.signal(signal.SIGINT, signal.SIG_IGN)
> +
> +# this function converts the info file to a dictionary format, sorta. 
> +def file_to_dict(path):
> +    client_info = {}
> +    with open(path) as f:
> +        for line in f:
> +            try:
> +                (key, val) = line.split(':')
> +                client_info[key] = val
> +    # FIXME: There has to be a better way of converting the info file to a dictionary.
> +            except ValueError:
> +                try:
> +                    (key, val) = line.split()
> +                    client_info[key] = val
> +                except:
> +                    pass
> +    return client_info
> +
> +# this function gets the paths from /proc/fs/nfsd/clients/
> +# returns a list of paths for each client which has nfs-share mounted.
> +def getpaths():
> +    path = []
> +    try:
> +        dirs = os.listdir('/proc/fs/nfsd/clients/')
> +    except OSError as reason:
> +        exit('%s' % reason)
> +    if len(dirs) !=0:
> +	    for i in dirs:
> +		    path.append('/proc/fs/nfsd/clients/' + i + '/states')
> +	    return (path)
> +    else:
> +	    exit('Nothing to process')
> +
> +# A single function to rule them all, in this function we gather all the data
> +# from already populated data_list and client_info.
> +def printer(data_list, argument):
> +    client_info_path = data_list.pop()
> +    client_info = file_to_dict(client_info_path)
> +    for i in data_list:
> +        for key in i:
> +            inode = i[key]['superblock'].split(':')[-1]
> +            # get the ip address from client_info as 'address:' note the extra
> +            # ':' as a suffix to address. If there is a better way to convert
> +            # the file to dictionary, please change the following value too.
> +            client_ip = client_info['address:']
> +            # The ip address is quoted, so we dequote it.
> +            client_ip = client_ip[1:-1]
> +            try:
> +                # if the nfs-server reboots while the nfs-client holds the files open,
> +                # the nfs-server would print the filename as '/'. For such instaces we
> +                # print the output as disconnected dentry instead of '/'.
> +                if(i[key]['filename']=='/'):
> +                    fname = 'disconnected dentry'
> +                else:
> +                    fname = i[key]['filename'].split('/')[-1]
> +            except KeyError:
> +                # for older kernels which do not have the fname patch in kernel, they
> +                # won't be able to see the fname field. Therefore post it as N/A.
> +                fname = "N/A"
> +            otype = i[key]['type']
> +            try:
> +                access = i[key]['access']
> +            except:
> +                access = ''
> +            try:
> +                deny = i[key]['deny']
> +            except:
> +                deny = ''
> +            hostname = client_info['name'].split()[-1].split('"')[0]
> +            hostname =  hostname.split('.')[0]
> +            otype = i[key]['type']
> +            # if the hostname is too long, it messes up with the output being in columns,
> +            # therefore we truncate the hostname followed by two '..' as suffix.
> +            if len(hostname) > 20:
> +                hostname = hostname[0:20] + '..'
> +            clientid = client_info['clientid'].strip()
> +            minorversion = client_info['minor version'].rstrip().rsplit()[0]
> +            # since some fields do not have deny column, we drop those if -t is either
> +            # layout or lock.
> +            drop = ['layout', 'lock']
> +
> +            # Printing the output this way instead of a single string which is concatenated
> +            # this makes it better to quickly add more columns in future.
> +            if(otype == argument.type or  argument.type == 'all'):
> +                print('%-13s' %inode, end='| ')
> +                print('%-7s' %otype, end='| ')
> +                if (argument.type not in drop):
> +                    print('%-7s' %access, end='| ')
> +                if (argument.type not in drop and argument.type !='deleg'):
> +                    print('%-5s' %deny, end='| ')
> +                if (argument.hostname == True):
> +                    print('%-22s' %hostname, end='| ')
> +                else:
> +                   print('%-22s' %client_ip, end='| ')
> +                if (argument.clientinfo == True) :
> +                    print('%-20s' %clientid, end='| ')
> +                    print('4.%-3s' %minorversion, end='| ')
> +                print(fname)
> +
> +def opener(path):
> +    try:
> +        with open(path, 'r') as nfsdata:
> +            data = yaml.load(nfsdata, Loader = yaml.BaseLoader)
> +            if data is not None:
> +                clientinfo = path.rsplit('/', 1)[0] + '/info'
> +                data.append(clientinfo)
> +                return data
> +
> +    except OSError as reason:
> +        print('%s' % reason)
> +
> +def print_cols(argument):
> +    title_inode = 'Inode number'
> +    title_otype = 'Type'
> +    title_access = 'Access'
> +    title_deny = 'Deny'
> +    title_fname = 'Filename'
> +    title_clientID = 'Client ID'
> +    title_hostname = 'Hostname'
> +    title_ip = 'ip address'
> +    title_nfsvers = 'vers'
> +
> +    drop = ['lock', 'layout']
> +    print(BBOLD, end='')
> +    print('%-13s' %title_inode, end='| ')
> +    print('%-7s' %title_otype, end='| ')
> +    if (argument.type not in drop):
> +        print('%-7s' %title_access, end='| ')
> +    if (argument.type not in drop and argument.type !='deleg'):
> +        print('%-5s' %title_deny, end='| ')
> +    if (argument.hostname == True):
> +        print('%-22s' %title_hostname, end='| ')
> +    else:
> +        print('%-22s' %title_ip, end='| ')
> +    if (argument.clientinfo == True):
> +        print('%-20s' %title_clientID, end='| ')
> +        print('%-5s' %title_nfsvers, end='| ')
> +    print(title_fname, end='')
> +    print(ENDC)
> +
> +def nfsd4_show():
> +
> +    parser = argparse.ArgumentParser(description = 'Parse the nfsd states and clientinfo files.')
> +    parser.add_argument('-t', '--type', metavar = 'type', type = str, choices = ['open',
> +        'deleg', 'lock', 'layout', 'all'],
> +        default = 'all',
> +        help = 'Input the type that you want to be printed: open, lock, deleg, layout, all')
> +    parser.add_argument('--clientinfo', action = 'store_true',
> +        help = 'output clients information, --hostname is implied.')
> +    parser.add_argument('--hostname', action = 'store_true',
> +        help = 'print hostname of client instead of its ip address. Longer hostnames are truncated.')
> +    parser.add_argument('-q', '--quiet', action = 'store_true',
> +        help = 'don\'t print the header information')
> +
> +    args = parser.parse_args()
> +    paths = getpaths()
> +    p = mp.Pool(mp.cpu_count(), init_worker)
> +    try:
> +        result = p.map(opener, paths)
> +        ### Drop None entries from list
> +        final_result = list(filter(None, result))
> +        p.close()
> +        p.join()
> +
> +        if len(final_result) !=0 and not args.quiet:
> +            print_cols(args)
> +
> +        for item in final_result:
> +            printer(item, args)
> +
> +    except KeyboardInterrupt:
> +        print('Caught KeyboardInterrupt, terminating workers')
> +        p.terminate()
> +        p.join()
> +
> +if __name__ == "__main__":
> +    nfsd4_show()
> 

