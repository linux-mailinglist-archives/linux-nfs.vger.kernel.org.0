Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B9F1BFF17
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2020 16:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgD3Osy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Apr 2020 10:48:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54423 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726130AbgD3Osu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Apr 2020 10:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588258127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q4t9tINQn93GZUGuo19CMuuD0S2FQr8iWUebN42jl+o=;
        b=Q/xDUpKZ0ioH7ZNh5MGHQwl+teobjzKAiUrfBNRzu5G7KZPOukyKZUZUgERiRA1/arw3z0
        DZv4E8GZna5aGic/80qsFK+tk/n/NVZF6Blwp5Qv/i7MrXm5OVF2nSKp+Kwid5iQ9y5utM
        fc+Pa69J15VXPHMkMxKKaQaFSWAbsXI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-uaj2hYmkPJOMwBLc4WFnBg-1; Thu, 30 Apr 2020 10:48:42 -0400
X-MC-Unique: uaj2hYmkPJOMwBLc4WFnBg-1
Received: by mail-lj1-f200.google.com with SMTP id p17so1042597ljn.12
        for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2020 07:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q4t9tINQn93GZUGuo19CMuuD0S2FQr8iWUebN42jl+o=;
        b=G4oUb6oijztHrYxm4K8FUjmvdrqYGToiq6DLkRml90R2bkFFXO/l++zX4DUySrVjaK
         WJmYqoKO9xQ6MbD8227VWZpuBJ79kryUiI1Jg7sInqxniTbQXHOaZdI9ME/3jRzUBIi3
         oQhONfRCOxQl7l+3IhGDlQUrYio2hrxbJ4573TdKOtZt8wN9nkNMndK6xfuSmP6hu4bC
         YKyVRQWpRELDoBK88NTP3b0KRIdT6TaVNSsrfZh70vq2dIlVDqzNigZvjJ2KTEazsWQF
         A3gSMEZmxDoAFAqGQAqrdaGsxJSjIxdgKXzmzKSC+SYxSN1SNmBI6IhuPY2nXqKa8RVa
         pySA==
X-Gm-Message-State: AGi0PuY+1lya3b6JZte+pptK6iFkZGbd8klDY5Fdv9iTTW+87xTRtj7u
        ZoWhCJ2iN6e4cPjWhzNj06BNMH26h46ywkLDU7oXsV2U6Bi8Aqg4MHrPZjddPJwKSA3QcVSZzyW
        5NnzkV/cViCIKyZwgxB+zobkad4A6oq3Vg/jH
X-Received: by 2002:a2e:9a8e:: with SMTP id p14mr2333082lji.142.1588258120442;
        Thu, 30 Apr 2020 07:48:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypJHwm5nP9zCev8z3WyzyNmvVrG5T9GyOsujlBVyB2QoKDmxH3a66CIedZCzAWBHSmO5OiRZyd7jSorbKoh9BoE=
X-Received: by 2002:a2e:9a8e:: with SMTP id p14mr2333065lji.142.1588258120041;
 Thu, 30 Apr 2020 07:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200428165142.GA1392654@nevermore.foobar.lan> <20200430140545.GA28617@fieldses.org>
In-Reply-To: <20200430140545.GA28617@fieldses.org>
From:   Achilles Gaikwad <agaikwad@redhat.com>
Date:   Thu, 30 Apr 2020 20:18:28 +0530
Message-ID: <CAK0MK2rvFJJHnC4c_-xyhvr63UwOOZsvHoaZjC6BHBaGup=ueg@mail.gmail.com>
Subject: Re: [PATCH] nfs-utils: add new tool nfsd4-show to parse output from
 proc files
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org, Steve Dickson <steved@redhat.com>,
        Kenneth Dsouza <kdsouza@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Good catch.
Thank you for the review! We'll send a v2 for this.

Best,
- Achilles
---

On Thu, Apr 30, 2020 at 7:35 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> Just one thing that jumped out at me:
>
> On Tue, Apr 28, 2020 at 10:21:42PM +0530, Achilles Gaikwad wrote:
> > +# this function converts the info file to a dictionary format, sorta. :)
> > +def file_to_dict(path):
> > +    client_info = {}
> > +    with open(path) as f:
> > +        for line in f:
> > +            try:
> > +                (key, val) = line.split(':')
>
> A colon could appear in a string and this would give the wrong results.
>
> These files are supposed to be legal json.  I think we want to use
> python's builtin "json" module rather than try to parse them on our own.
>
> --b.
>
> > +                client_info[key] = val
> > +    # FIXME: There has to be a better way of converting tscrews he info file to a dictionary.
> > +            except ValueError:
> > +                try:
> > +                    (key, val) = line.split()
> > +                    client_info[key] = val
> > +                except:
> > +                    pass
> > +    return client_info
> > +
> > +# this functino gets the paths from /proc/fs/nfsd/clients/
> > +# returns a list of paths for each client which has nfs-share mounted.
> > +def getpaths():
> > +    path = []
> > +    try:
> > +        dirs = os.listdir('/proc/fs/nfsd/clients/')
> > +    except OSError as reason:
> > +        exit('%s' % reason)
> > +    if len(dirs) !=0:
> > +         for i in dirs:
> > +                 path.append('/proc/fs/nfsd/clients/' + i + '/states')
> > +         return (path)
> > +    else:
> > +         exit('Nothing to process')
> > +
> > +# A single function to rule them all, in this function we gather all the data
> > +# from already populated data_list and client_info.
> > +def printer(data_list, argument):
> > +    client_info_path = data_list.pop()
> > +    client_info = file_to_dict(client_info_path)
> > +    for i in data_list:
> > +        for key in i:
> > +            inode = i[key]['superblock'].split(':')[-1]
> > +            # get the ip address from client_info as 'address:' note the extra
> > +            # ':' as a suffix to address. If there is a better way to convert
> > +            # the file to dictionary, please change the following value too.
> > +            client_ip = client_info['address:']
> > +            # The ip address is quoted, so we dequote it.
> > +            client_ip = client_ip[1:-1]
> > +            try:
> > +                # if the nfs-server reboots while the nfs-client holds the files open,
> > +                # the nfs-server would print the filename as '/'. For such instaces we
> > +                # print the output as disconnected dentry instead of '/'.
> > +                if(i[key]['filename']=='/'):
> > +                    fname = 'disconnected dentry'
> > +                else:
> > +                    fname = i[key]['filename'].split('/')[-1]
> > +            except KeyError:
> > +                # for older kernels which do not have the fname patch in kernel, they
> > +                # won't be able to see the fname field. Therefore post it as N/A.
> > +                fname = "N/A"
> > +            otype = i[key]['type']
> > +            try:
> > +                access = i[key]['access']
> > +            except:
> > +                access = ''
> > +            try:
> > +                deny = i[key]['deny']
> > +            except:
> > +                deny = ''
> > +            hostname = client_info['name'].split()[-1].split('"')[0]
> > +            hostname =  hostname.split('.')[0]
> > +            otype = i[key]['type']
> > +            # if the hostname is too long, it messes up with the output being in columns,
> > +            # therefore we truncate the hostname followed by two '..' as suffix.
> > +            if len(hostname) > 20:
> > +                hostname = hostname[0:20] + '..'
> > +            clientid = client_info['clientid'].strip()
> > +            minorversion = client_info['minor version'].rstrip().rsplit()[0]
> > +            # since some fields do not have deny column, we drop those if -t is either
> > +            # layout or lock.
> > +            drop = ['layout', 'lock']
> > +
> > +            # Printing the output this way instead of a single string which is concatenated
> > +            # this makes it better to quickly add more columns in future.
> > +            if(otype == argument.type or  argument.type == 'all'):
> > +                print('%-13s' %inode, end='| ')
> > +                print('%-7s' %otype, end='| ')
> > +                if (argument.type not in drop):
> > +                    print('%-7s' %access, end='| ')
> > +                if (argument.type not in drop and argument.type !='deleg'):
> > +                    print('%-5s' %deny, end='| ')
> > +                if (argument.hostname == True):
> > +                    print('%-22s' %hostname, end='| ')
> > +                else:
> > +                   print('%-22s' %client_ip, end='| ')
> > +                if (argument.clientinfo == True) :
> > +                    print('%-20s' %clientid, end='| ')
> > +                    print('4.%-3s' %minorversion, end='| ')
> > +                print(fname)
> > +
> > +def opener(path):
> > +    try:
> > +        with open(path, 'r') as nfsdata:
> > +            data = yaml.load(nfsdata, Loader = yaml.BaseLoader)
> > +            if data is not None:
> > +                clientinfo = path.rsplit('/', 1)[0] + '/info'
> > +                data.append(clientinfo)
> > +                return data
> > +
> > +    except OSError as reason:
> > +        print('%s' % reason)
> > +
> > +def print_cols(argument):
> > +    title_inode = 'Inode number'
> > +    title_otype = 'Type'
> > +    title_access = 'Access'
> > +    title_deny = 'Deny'
> > +    title_fname = 'Filename'
> > +    title_clientID = 'Client ID'
> > +    title_hostname = 'Hostname'
> > +    title_ip = 'ip address'
> > +    title_nfsvers = 'vers'
> > +
> > +    drop = ['lock', 'layout']
> > +    print(BBOLD, end='')
> > +    print('%-13s' %title_inode, end='| ')
> > +    print('%-7s' %title_otype, end='| ')
> > +    if (argument.type not in drop):
> > +        print('%-7s' %title_access, end='| ')
> > +    if (argument.type not in drop and argument.type !='deleg'):
> > +        print('%-5s' %title_deny, end='| ')
> > +    if (argument.hostname == True):
> > +        print('%-22s' %title_hostname, end='| ')
> > +    else:
> > +        print('%-22s' %title_ip, end='| ')
> > +    if (argument.clientinfo == True):
> > +        print('%-20s' %title_clientID, end='| ')
> > +        print('%-5s' %title_nfsvers, end='| ')
> > +    print(title_fname, end='')
> > +    print(ENDC)
> > +
> > +def nfsd4_show():
> > +
> > +    parser = argparse.ArgumentParser(description = 'Parse the nfsd states and clientinfo files.')
> > +    parser.add_argument('-t', '--type', metavar = 'type', type = str, choices = ['open',
> > +        'deleg', 'lock', 'layout', 'all'],
> > +        default = 'all',
> > +        help = 'Input the type that you want to be printed: open, lock, deleg, layout, all')
> > +    parser.add_argument('--clientinfo', action = 'store_true',
> > +        help = 'output clients information, --hostname is implied.')
> > +    parser.add_argument('--hostname', action = 'store_true',
> > +        help = 'print hostname of client instead of its ip address. Longer hostnames are truncated.')
> > +    parser.add_argument('-q', '--quiet', action = 'store_true',
> > +        help = 'don\'t print the header information')
> > +
> > +    args = parser.parse_args()
> > +    paths = getpaths()
> > +    p = mp.Pool(mp.cpu_count(), init_worker)
> > +    try:
> > +        result = p.map(opener, paths)
> > +        p.close()
> > +        p.join()
> > +        if len(result) !=0 and not args.quiet and result[0] is not None:
> > +            print_cols(args)
> > +
> > +        for i in result:
> > +            if i is not None:
> > +                printer(i, args)
> > +
> > +    except KeyboardInterrupt:
> > +        print('Caught KeyboardInterrupt, terminating workers')
> > +        p.terminate()
> > +        p.join()
> > +
> > +if __name__ == "__main__":
> > +    nfsd4_show()
> > --
> > 2.25.4
>

