Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CDB39038D
	for <lists+linux-nfs@lfdr.de>; Tue, 25 May 2021 16:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhEYOMF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 May 2021 10:12:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32519 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233399AbhEYOMF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 May 2021 10:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621951835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yNekuy0qSqT8bjyk6vSVhBPubH1Sm7iFzxVKEvV6/wo=;
        b=Yv4cy1Nj7zvDszixISUkz2UrBq5suXpQpeXX1/0dWGtI+KE9Br2LELep1zggC72fhuGIzK
        rZadWVCXKC87eceqIi+IDzyySqG/hZ3WNOGzHDLZF85lj8u1lB1qOpm36AjKxhXB6HJzE0
        SEWZot90vJ6/4uNFjBQnUs5cusXtc5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-jZH_RPysN3WmTJuUGxIX_Q-1; Tue, 25 May 2021 10:10:33 -0400
X-MC-Unique: jZH_RPysN3WmTJuUGxIX_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 268EB107ACF3;
        Tue, 25 May 2021 14:10:32 +0000 (UTC)
Received: from pick.fieldses.org (ovpn-117-74.rdu2.redhat.com [10.10.117.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC22C5C1B4;
        Tue, 25 May 2021 14:10:31 +0000 (UTC)
Received: by pick.fieldses.org (Postfix, from userid 2815)
        id 2AF76120639; Tue, 25 May 2021 10:10:31 -0400 (EDT)
Date:   Tue, 25 May 2021 10:10:31 -0400
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-nfs@vger.kernel.org, "Yong Sun (Sero)" <yosun@suse.com>
Subject: Re: [PATCH pynfs 2/3] server: Allow to print JSON format
Message-ID: <YK0FV/mvmbIzSpKJ@pick.fieldses.org>
References: <20210524144251.30196-1-pvorel@suse.cz>
 <20210524144251.30196-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524144251.30196-2-pvorel@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I've got nothing against this, but I'm curious why you need it.

--b.

On Mon, May 24, 2021 at 04:42:50PM +0200, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  nfs4.0/testserver.py |  7 ++++++-
>  nfs4.1/testmod.py    | 40 +++++++++++++++++++++++++++++++++++++++-
>  nfs4.1/testserver.py |  6 +++++-
>  3 files changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/nfs4.0/testserver.py b/nfs4.0/testserver.py
> index 0ef010a..f2c4156 100755
> --- a/nfs4.0/testserver.py
> +++ b/nfs4.0/testserver.py
> @@ -85,6 +85,8 @@ def scan_options(p):
>                   help="Skip final cleanup of test directory")
>      p.add_option("--outfile", "--out", default=None, metavar="FILE",
>                   help="Store test results in FILE [%default]")
> +    p.add_option("--jsonout", "--json", default=None, metavar="FILE",
> +                 help="Store test results in JSON format [%default]")
>      p.add_option("--xmlout", "--xml", default=None, metavar="FILE",
>                   help="Store test results in xml format [%default]")
>      p.add_option("--debug_fail", action="store_true", default=False,
> @@ -378,8 +380,11 @@ def main():
>      if fail:
>          print("\nWARNING: could not clean testdir due to:\n%s\n" % err)
>  
> -    if opt.xmlout is not None:
> +    if opt.jsonout is not None:
> +        testmod.json_printresults(tests, opt.jsonout)
> +    elif opt.xmlout is not None:
>          testmod.xml_printresults(tests, opt.xmlout)
> +
>      if nfail < 0:
>          sys.exit(3)
>      if nfail > 0:
> diff --git a/nfs4.1/testmod.py b/nfs4.1/testmod.py
> index e368853..4b4ed24 100644
> --- a/nfs4.1/testmod.py
> +++ b/nfs4.1/testmod.py
> @@ -13,6 +13,7 @@ import re
>  import sys
>  import time
>  from traceback import format_exception, print_exc
> +import json
>  import xml.dom.minidom
>  import datetime
>  
> @@ -467,6 +468,43 @@ def printresults(tests, opts, file=None):
>            (count[SKIP], count[FAIL], count[WARN], count[PASS]), file=file)
>      return count[FAIL]
>  
> +def json_printresults(tests, file_name, suite='all'):
> +    with open(file_name, 'w') as fd:
> +        failures = 0
> +        skipped = 0
> +        total_time = 0
> +        data = {}
> +        data["tests"] = len(tests)
> +        data["errors"] = 0
> +        data["timestamp"] = str(datetime.datetime.now())
> +        data["name"] = suite
> +        data["testcase"] = []
> +        for t in tests:
> +            test = {
> +                "name": t.name,
> +                "classname": t.suite,
> +                "time": str(t.time_taken),
> +            }
> +
> +            total_time += t.time_taken
> +            if t.result == TEST_FAIL:
> +                failures += 1
> +                test["failure"] = {
> +                        "message" : t.result.msg,
> +                        "err" : ''.join(t.result.tb)
> +                }
> +            elif t.result == TEST_OMIT:
> +                skipped += 1
> +                test["skipped"] = 1
> +
> +            data["testcase"].append(test)
> +
> +        data["failures"] = failures
> +        data["skipped"] = skipped
> +        data["time"] = total_time
> +
> +        fd.write(json.dumps(data, indent=4, sort_keys=True))
> +
>  def xml_printresults(tests, file_name, suite='all'):
>      with open(file_name, 'w') as fd:
>          failures = 0
> @@ -484,7 +522,7 @@ def xml_printresults(tests, file_name, suite='all'):
>              testsuite.appendChild(testcase)
>              testcase.setAttribute("name", t.name)
>              testcase.setAttribute("classname", t.suite)
> -            testcase.setAttribute("time", str(t.time_taken))
> +            testcase.setAttribute("time", t.time_taken)
>  
>              total_time += t.time_taken
>              if t.result == TEST_FAIL:
> diff --git a/nfs4.1/testserver.py b/nfs4.1/testserver.py
> index d3c44c7..085f007 100755
> --- a/nfs4.1/testserver.py
> +++ b/nfs4.1/testserver.py
> @@ -68,6 +68,8 @@ def scan_options(p):
>                   help="Skip final cleanup of test directory")
>      p.add_option("--outfile", "--out", default=None, metavar="FILE",
>                   help="Store test results in FILE [%default]")
> +    p.add_option("--jsonout", "--json", default=None, metavar="FILE",
> +                 help="Store test results in JSON format [%default]")
>      p.add_option("--xmlout", "--xml", default=None, metavar="FILE",
>                   help="Store test results in xml format [%default]")
>      p.add_option("--debug_fail", action="store_true", default=False,
> @@ -363,7 +365,9 @@ def main():
>      if fail:
>          print("\nWARNING: could not clean testdir due to:\n%s\n" % err)
>  
> -    if opt.xmlout is not None:
> +    if opt.jsonout is not None:
> +        testmod.json_printresults(tests, opt.jsonout)
> +    elif opt.xmlout is not None:
>          testmod.xml_printresults(tests, opt.xmlout)
>  
>  if __name__ == "__main__":
> -- 
> 2.31.1
> 

