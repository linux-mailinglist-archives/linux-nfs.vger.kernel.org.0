Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E876C5A86
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Mar 2023 00:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjCVXhC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Mar 2023 19:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCVXhA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Mar 2023 19:37:00 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C5123A64
        for <linux-nfs@vger.kernel.org>; Wed, 22 Mar 2023 16:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679528210; x=1711064210;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=09Qms904bOmUjhbXd6xEeHgGApY/+/dzqrMlIByjay8=;
  b=gTH1HM502AfFEDt1rf1R58gg7O4avBrvvKP7OCOKo8EFP2SW04YDq+kH
   Tv6pkfvze/bhKDclnZRbCeIuJ4+wLh9z23d1HNcf/0uYSiQzjf8T3Ilvw
   jcEwm/16am+SZB8IeuCGq14WBkBweRwepOG2VpokeLd59lBWLOwoDg1nm
   zXmuGcHM5PaESr/J3IsQ9MAhg51wF/4whVOS11gjJjr6xffEk/Lv0NXSn
   EeEX04FOF8A6e/ONTjXoFD3UvyozvbeeEdt+C4XVEvHWa+bPPot+/KxZg
   xYCXCXmwEcEAHz8YkyXuYuaXJRzivtjZdHRMxsmCHWAzdevlZNWqUeLRI
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="224559511"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 07:36:42 +0800
IronPort-SDR: SjjhDebwBGTyZzEc5wcVSduSDDEoESeo0iqo339s1ZSBpSoEwc7HTgPZagWaGDsSDdNsrpdPA2
 wUm2JlRYpbCmV5Xo96Ytv2Ucs9Ur7XsmX0it4YUGE+h6QKqUyVWFJQ77Gr2s2q3XfXz9RqCUC1
 /QG975uPBp1sisOCZOtrFIUUQ2FDI6+BaOd8WZrl9g8W16ZrQSGhMvMKga/IeaBj5QZ0DJED21
 AECS8KrA4WYjurQxcbZpUAeungS+UblRJE8dyx2R+z9Wo/92t2cklLlNMIVTyrF2T/IiJmpA/3
 3TQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 15:47:19 -0700
IronPort-SDR: A/QnKoQIoUH9TRh4IbvePEw9krQudXr2vRkw3Bzg+jOvBRDjoIZPaoragYjOMz/ftzZfUb+2n5
 1Tvy3iOU/lXFXIhDXZ3JmqWkSdX+CWBIIQLULZokf8ugQiL2iunaATKbZrFLk+2mniN8I+d9sI
 2AsSdS+BYyrqZOXo3SF+u8qAMohZF0lZ6RH11qHDZdSKbx7PxfUQ1vReLn/vO/dC3aGf+XvWCv
 UA0VJgKBC8r7vIF+tsjZKu0iFFP/7GwMlxn3dNXREPXKvAn5IVOQ5uyAXlUlUeBtdh9SIFh4x8
 r5g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Mar 2023 16:36:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PhlHG4D4mz1RtVx
        for <linux-nfs@vger.kernel.org>; Wed, 22 Mar 2023 16:36:42 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1679528202; x=1682120203; bh=09Qms904bOmUjhbXd6xEeHgGApY/+/dzqrM
        lIByjay8=; b=MFws7Jvfl7rAxhhctrUR4tO/8eRHlWd8P+oSYG32AUDddxyfSEc
        iSeE+t8PU8Fix6ELXo9q06R/bS/0ZWxsrcg3MthEwF/ffcWJeacBI9MILMUBGXna
        dEYp2SW9K3xetu6X0VUPD1jsnFy5NoGefpCyAL8NcNNMNTJGo4oxNXBGUxp01/tP
        ek4NR8J+Z6CyJ+MSXn5TPxJ5GLMRsiayTE7QrC/Iy+Zc8mkXnGPzWcjHte84q22g
        ZekOb9i4YY+JzzHVZAvY/2gsy3z378kYGQfC7ASI/3qpR93hMVQ0mKYcnNT94v2i
        wK6t93C3GlrbR5rb0J8MUbydpSmxuWP985A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oOWNWU-zxQbH for <linux-nfs@vger.kernel.org>;
        Wed, 22 Mar 2023 16:36:42 -0700 (PDT)
Received: from [10.225.163.96] (unknown [10.225.163.96])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PhlHF0mbwz1RtVm;
        Wed, 22 Mar 2023 16:36:40 -0700 (PDT)
Message-ID: <5efc95e3-8a9b-49bd-8532-ec79a37b1697@opensource.wdc.com>
Date:   Thu, 23 Mar 2023 08:36:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 09/10] nfs: convert to kobject_del_and_put()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230322165905.55389-1-frank.li@vivo.com>
 <20230322165905.55389-8-frank.li@vivo.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230322165905.55389-8-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 3/23/23 01:59, Yangtao Li wrote:
> Use kobject_del_and_put() to simplify code.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>


-- 
Damien Le Moal
Western Digital Research

