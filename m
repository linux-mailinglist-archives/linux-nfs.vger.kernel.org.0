Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5649B1CB54F
	for <lists+linux-nfs@lfdr.de>; Fri,  8 May 2020 19:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEHRBA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 May 2020 13:01:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36356 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726750AbgEHRA7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 May 2020 13:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588957257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OjBSluDvI3Tamxr9Yoj5oFG635OOqyk+sbKpogBiD10=;
        b=RtXENGtO+7A8/qLoQsvPq8jTPqHXvISdDJTaPVT24HPrj8I4P8Mx845Qw8zZZOzJazytX7
        MghkTEyEzsztZw1PAE4peA7rA7oCFGEvmcWVi8t1riXRNslxfC7ts5bEOueVfdnYMY/flA
        vR75V7udGRi+PF/QnKBvCjpJWjlUp/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-sCWKjvxkOb2gyBr6fudDTQ-1; Fri, 08 May 2020 13:00:41 -0400
X-MC-Unique: sCWKjvxkOb2gyBr6fudDTQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07F178014D6;
        Fri,  8 May 2020 17:00:38 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-12.phx2.redhat.com [10.3.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1469E70890;
        Fri,  8 May 2020 17:00:36 +0000 (UTC)
Subject: Re: [PATCH] nfs-utils: add new tool nfsd4-show to parse output from
 proc files
To:     Achilles Gaikwad <agaikwad@redhat.com>, linux-nfs@vger.kernel.org
Cc:     bfields@fieldses.org, kdsouza@redhat.com
References: <20200428165142.GA1392654@nevermore.foobar.lan>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <19946bbc-6612-3f5c-d9b4-f6de541cf8e7@RedHat.com>
Date:   Fri, 8 May 2020 13:00:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200428165142.GA1392654@nevermore.foobar.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 4/28/20 12:51 PM, Achilles Gaikwad wrote:
> This tool parses the output from the following files
> 
>  /proc/fs/nfsd/clients/*/{states,info}
> 
> - Tool has the following parameters so far:
This is looking very good! A couple things.... 

A man page is needed and what do you think about
changing the name to nfsdclts? I realize only v4 
clients will be shown but that's a doc issue imho.

Basically I'm trying to some type of command name convention

BTW, I'm thinking this is going to be a very useful tool!
Nice work!

steved.
 
> 
> ~~~
> $ /usr/sbin/nfsd4-show -h
> usage: nfsd4-show [-h] [-t type] [--clientinfo] [--hostname] [-q]
> 
> Parse the nfsd states and clientinfo files.
> 
> optional arguments:
>   -h, --help            show this help message and exit
>   -t type, --type type  Input the type that you want to be printed: open,
>                         lock, deleg, layout, all
>   --clientinfo          output clients information, --hostname is implied.
>   --hostname            print hostname of client instead of its ip address.
>                         Longer hostnames are truncated.
>   -q, --quiet           don't print the header information
> ~~~
> 
> - This tool enables the output to have both ip address and filaname[1]
> 
> ~~~
> Inode number | Type   | ip address            | Filename
> 33811576     | lock   | [::1]:682             | foobar
> ~~~
> 
> - You can also display just the open files
> 
> ~~~
> Inode number | Type   | Access | Deny | ip address            | Filename
> :::
> 226493407    | open   | r-     | --   | 10.65.211.137:708     | 999
> 226493409    | open   | r-     | --   | 10.65.211.137:708     | ff
> 226493410    | open   | r-     | --   | 10.65.211.137:708     | foo
> 226493413    | open   | r-     | --   | 10.65.211.137:708     | open_lock.py
> 33811575     | open   | r-     | --   | [::1]:682             | file
> 33811576     | open   | rw     | --   | [::1]:682             | foobar
> :::
> ~~~
> 
> - Handles disconnected dentries from userspace by showing filename as :
> 
> ~~~
> Inode number | Type   | Access | Deny | ip address            | Filename
> :::
> 226493409    | open   | r-     | --   | 10.65.211.66:867      | disconnected dentry
> 226493409    | deleg  | r      |      | 10.65.211.66:867      | disconnected dentry
> 226493410    | open   | r-     | --   | 10.65.211.66:867      | disconnected dentry
> 226493410    | deleg  | r      |      | 10.65.211.66:867      | disconnected dentry
> ~~~
> 
> - Automatically drop the deny column for delegation
> 
> ~~~
> Inode number | Type   | Access | ip address            | Filename
> 226726004    | deleg  | r      | 10.65.211.137:708     | foo
> 226726013    | deleg  | r      | 10.65.211.137:708     | bar
> ~~~
> 
> - clientinfo would show the version of nfs that the client has mounted the share with
> 
>   the client id.
> 
> ~~~
> Inode number | Type   | Access | Deny | ip address            | Client ID           | vers | Filename
> 226726004    | open   | r-     | --   | 10.65.211.137:708     | 0xf2924e155ea84ae8  | 4.2  | foo
> 226726004    | deleg  | r      |      | 10.65.211.137:708     | 0xf2924e155ea84ae8  | 4.2  | foo
> ~~~
> 
> - hostname option would show the hostname instead of ip addresses
> 
> ~~~
> Inode number | Type   | Access | Deny | Hostname              | Filename
> 227054876    | open   | r-     | --   | vm137                 | fubar
> ~~~
> 
> If you do not like the header, please use the -q option.
> 
> Your feedback and review is highly apprecaited!
> 
> You will need the following patch for filename to be displayed:
> [1] https://www.spinics.net/lists/linux-nfs/msg77332.html
> 
> Signed-off-by: Achilles Gaikwad <agaikwad@redhat.com>
> Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
> ---
>  configure.ac                   |   1 +
>  tools/Makefile.am              |   2 +-
>  tools/nfsd4-show/Makefile.am   |   9 ++
>  tools/nfsd4-show/nfsd4-show.py | 219 +++++++++++++++++++++++++++++++++
>  4 files changed, 230 insertions(+), 1 deletion(-)
>  create mode 100644 tools/nfsd4-show/Makefile.am
>  create mode 100755 tools/nfsd4-show/nfsd4-show.py
> 
> diff --git a/configure.ac b/configure.ac
> index 00b32800..366f9b7c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -689,6 +689,7 @@ AC_CONFIG_FILES([
>  	tools/rpcgen/Makefile
>  	tools/mountstats/Makefile
>  	tools/nfs-iostat/Makefile
> +	tools/nfsd4-show/Makefile
>  	tools/nfsconf/Makefile
>  	tools/clddb-tool/Makefile
>  	utils/Makefile
> diff --git a/tools/Makefile.am b/tools/Makefile.am
> index 53e61170..3cebbe95 100644
> --- a/tools/Makefile.am
> +++ b/tools/Makefile.am
> @@ -12,6 +12,6 @@ if CONFIG_NFSDCLD
>  OPTDIRS += clddb-tool
>  endif
>  
> -SUBDIRS = locktest rpcdebug nlmtest mountstats nfs-iostat $(OPTDIRS)
> +SUBDIRS = nfsd4-show locktest rpcdebug nlmtest mountstats nfs-iostat $(OPTDIRS)
>  
>  MAINTAINERCLEANFILES = Makefile.in
> diff --git a/tools/nfsd4-show/Makefile.am b/tools/nfsd4-show/Makefile.am
> new file mode 100644
> index 00000000..1b57cfb2
> --- /dev/null
> +++ b/tools/nfsd4-show/Makefile.am
> @@ -0,0 +1,9 @@
> +## Process this file with automake to produce Makefile.in
> +PYTHON_FILES =  nfsd4-show.py
> +
> +all-local: $(PYTHON_FILES)
> +
> +install-data-hook:
> +	$(INSTALL) -m 755 nfsd4-show.py $(DESTDIR)$(sbindir)/nfsd4-show
> +
> +MAINTAINERCLEANFILES=Makefile.in
> \ No newline at end of file
> diff --git a/tools/nfsd4-show/nfsd4-show.py b/tools/nfsd4-show/nfsd4-show.py
> new file mode 100755
> index 00000000..52775e66
> --- /dev/null
> +++ b/tools/nfsd4-show/nfsd4-show.py
> @@ -0,0 +1,219 @@
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
> +# this function converts the info file to a dictionary format, sorta. :)
> +def file_to_dict(path):
> +    client_info = {}
> +    with open(path) as f:
> +        for line in f:
> +            try:
> +                (key, val) = line.split(':')
> +                client_info[key] = val
> +    # FIXME: There has to be a better way of converting tscrews he info file to a dictionary.
> +            except ValueError:
> +                try:
> +                    (key, val) = line.split()
> +                    client_info[key] = val
> +                except:
> +                    pass
> +    return client_info
> +
> +# this functino gets the paths from /proc/fs/nfsd/clients/
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
> +        p.close()
> +        p.join()
> +        if len(result) !=0 and not args.quiet and result[0] is not None:
> +            print_cols(args)
> +
> +        for i in result:
> +            if i is not None:
> +                printer(i, args)
> +
> +    except KeyboardInterrupt:
> +        print('Caught KeyboardInterrupt, terminating workers')
> +        p.terminate()
> +        p.join()
> +
> +if __name__ == "__main__":
> +    nfsd4_show()
> 

