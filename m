Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25120191BD9
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2020 22:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgCXVSa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 17:18:30 -0400
Received: from fieldses.org ([173.255.197.46]:53742 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbgCXVSa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Mar 2020 17:18:30 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id A7FC21F65; Tue, 24 Mar 2020 17:18:29 -0400 (EDT)
Date:   Tue, 24 Mar 2020 17:18:29 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH] rpc: fix str to bytes conversion
Message-ID: <20200324211829.GB18421@fieldses.org>
References: <20200318104031.289921-1-tigran.mkrtchyan@desy.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318104031.289921-1-tigran.mkrtchyan@desy.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Applied.--b.

On Wed, Mar 18, 2020 at 11:40:31AM +0100, Tigran Mkrtchyan wrote:
> fix back channel ping from server
> ---
>  rpc/rpc.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/rpc/rpc.py b/rpc/rpc.py
> index c536384..d15cf06 100644
> --- a/rpc/rpc.py
> +++ b/rpc/rpc.py
> @@ -693,8 +693,11 @@ class ConnectionHandler(object):
>                  status, result, notify = tuple
>              if result is None:
>                  result = b''
> +            if isinstance(result, str):
> +                result = bytes(result, encoding='UTF-8')
> +
>              if not isinstance(result, bytes):
> -                raise TypeError("Expected string")
> +                raise TypeError("Expected bytes, got %s" % type(result))
>              # status, result = method(msg_data, call_info)
>              log_t.debug("Called method, got %r, %r" % (status, result))
>          except rpclib.RPCDrop:
> -- 
> 2.25.1
