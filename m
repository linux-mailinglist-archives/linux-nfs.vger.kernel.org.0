Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F147926805B
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Sep 2020 18:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgIMQ4W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Sep 2020 12:56:22 -0400
Received: from out20-73.mail.aliyun.com ([115.124.20.73]:39011 "EHLO
        out20-73.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgIMQ4R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Sep 2020 12:56:17 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07447656|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.401913-0.00103094-0.597056;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07440;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.IWaa4Sp_1600016171;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IWaa4Sp_1600016171)
          by smtp.aliyun-inc.com(10.147.42.135);
          Mon, 14 Sep 2020 00:56:11 +0800
Date:   Mon, 14 Sep 2020 00:56:11 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     fstests@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/3] common/attr: make _require_attrs more fine-grained
Message-ID: <20200913165611.GM3853@desktop>
References: <20200910194355.5977-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910194355.5977-1-fllinden@amazon.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 10, 2020 at 07:43:53PM +0000, Frank van der Linden wrote:
> Filesystems may not support all xattr types. But, _require_attr assumes
> that being able to use "user" namespace xattrs means that all namespaces
> ("trusted", "system", etc) are supported. This breaks on NFS, that only
> supports the "user" namespace, and a few cases in the "system" namespace.
> 
> Change _require_attrs to optionally take namespace arguments that specify
> the namespaces to check for. The default behavior (no arguments) is still
> to check for the "user" namespace only.
> 
> Signed-off-by: Frank van der Linden <fllinden@amazon.com>

This patchset looks great to me, thanks!

Some minor nits below (and I've fixed them on commit, so there's no need
to resend :)

> ---
>  common/attr | 49 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/common/attr b/common/attr
> index 20049de0..c60cb6ed 100644
> --- a/common/attr
> +++ b/common/attr
> @@ -175,30 +175,43 @@ _list_acl()
>  
>  _require_attrs()
>  {
> +    local args
> +    local nsp
> +
> +    if [ $# -eq 0 ];
> +    then

We prefer the following coding style in fstests

	if [ $# -eq 0 ]; then
		args="user"
	else
		args="$*"
	fi

> +      args="user"
> +    else
> +      args="$*"
> +    fi

And you've almost re-written the whole _require_attrs(), it's better to
use tab as indention instead of 4 spaces (we're in the (very slow)
progress converting all 4-spaces indention to tab, except there're old
code using 4-spaces around).

> +
>      [ -n "$ATTR_PROG" ] || _notrun "attr command not found"
>      [ -n "$GETFATTR_PROG" ] || _notrun "getfattr command not found"
>      [ -n "$SETFATTR_PROG" ] || _notrun "setfattr command not found"
>  
> -    #
> -    # Test if chacl is able to write an attribute on the target filesystems.
> -    # On really old kernels the system calls might not be implemented at all,
> -    # but the more common case is that the tested filesystem simply doesn't
> -    # support attributes.  Note that we can't simply list attributes as
> -    # various security modules generate synthetic attributes not actually
> -    # stored on disk.
> -    #
> -    touch $TEST_DIR/syscalltest
> -    attr -s "user.xfstests" -V "attr" $TEST_DIR/syscalltest > $TEST_DIR/syscalltest.out 2>&1
> -    cat $TEST_DIR/syscalltest.out >> $seqres.full
> +    for nsp in $args
> +    do

Same here, use the format below

	for nsp in $args; do
		<do things here>
	done

Thanks,
Eryu

> +      #
> +      # Test if chacl is able to write an attribute on the target filesystems.
> +      # On really old kernels the system calls might not be implemented at all,
> +      # but the more common case is that the tested filesystem simply doesn't
> +      # support attributes.  Note that we can't simply list attributes as
> +      # various security modules generate synthetic attributes not actually
> +      # stored on disk.
> +      #
> +      touch $TEST_DIR/syscalltest
> +      $SETFATTR_PROG -n "$nsp.xfstests" -v "attr" $TEST_DIR/syscalltest > $TEST_DIR/syscalltest.out 2>&1
> +      cat $TEST_DIR/syscalltest.out >> $seqres.full
>  
> -    if grep -q 'Function not implemented' $TEST_DIR/syscalltest.out; then
> -      _notrun "kernel does not support attrs"
> -    fi
> -    if grep -q 'Operation not supported' $TEST_DIR/syscalltest.out; then
> -      _notrun "attrs not supported by this filesystem type: $FSTYP"
> -    fi
> +      if grep -q 'Function not implemented' $TEST_DIR/syscalltest.out; then
> +        _notrun "kernel does not support attrs"
> +      fi
> +      if grep -q 'Operation not supported' $TEST_DIR/syscalltest.out; then
> +        _notrun "attr namespace $nsp not supported by this filesystem type: $FSTYP"
> +      fi
>  
> -    rm -f $TEST_DIR/syscalltest.out
> +      rm -f $TEST_DIR/syscalltest.out
> +    done
>  }
>  
>  _require_attr_v1()
> -- 
> 2.16.6
