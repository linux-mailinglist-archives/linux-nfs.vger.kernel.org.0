Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F10B1A2DFA
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Apr 2020 05:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgDIDcI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Apr 2020 23:32:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34046 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgDIDcI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Apr 2020 23:32:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id l14so4353230pgb.1
        for <linux-nfs@vger.kernel.org>; Wed, 08 Apr 2020 20:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oqJTPtpkTpUkbGBrE2+CxYaGq608cjc1ZWSBRo2kHeU=;
        b=pFtY7jl18S9tEXCrJ+vE7hmtCUsxe89l2Pnuj3IxMUcChtCB7DBKD0Eu8Rkf0IV2Ry
         XIy5Sc3wqA/wE1P+lm2RwDF3cvO30Iv/PT75PWi18sQGXw63lrwrNxVrISY168C3mzra
         MHPpxXNev4dYA+Hr41aD2Z60IeDCyWT3JaEgKryj0XRl6fgEqkWtV/Uy9emUvrH0KE4g
         Mv9D6Rn5DPv8PP3k6FgKwPw7mOnT014oIW/i1C5YK+SIxMRKNMOY19IUjpZeV4D8jkrb
         +v4hj1DqPYN0omYsRi16ao61EXMZ5RRnurlttsopTpGT+J4kjYGKAhN47APQ5BW/Cbpt
         VPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oqJTPtpkTpUkbGBrE2+CxYaGq608cjc1ZWSBRo2kHeU=;
        b=PgtYayZcJJN+AeP1J8HRy21oeeBwS25zRo1Xdw+cdFpXM+e3uhGPjYJpn4qIKQdZrS
         p6UKilxRFcxKs2EVnfq4drYtt4eFWdrqeonX6Ek30wL+4uFTL1jhrgPsIj0gTzyYNrl3
         YqZxY7d74OZWiYDpeUHAk6/UyDBJ/KlDTKsJfDwjO1ywbFXyP6vSiog6zy1YT10Zrvcj
         +u/O/n1udxeJa9Rg49RfY6bxMHi0wkQDbNENkMOrOFeRDjKKg0+g9/WPO75NK90N1ehm
         einFkGjuI4SyhrdOLx1CA7xFlAx4fXmb/h3ARPNXPNXLo9GIOKRG6wPbTIVp9Dk/y+kA
         rE0A==
X-Gm-Message-State: AGi0PuaORk/uw6RVI77fPRohlNCuef6elnitJTrQauQicdUz2Lqdiiys
        4HpOlgLT4b/B1AZaSN2fETE=
X-Google-Smtp-Source: APiQypJr+N1+27tpCvPrkmxYxqY0cXd78xAvwavjGbjTOWxQwSBgGnx0tNcd6ETO8KIlrlQfU6ujNg==
X-Received: by 2002:a63:a35a:: with SMTP id v26mr10496800pgn.40.1586403127299;
        Wed, 08 Apr 2020 20:32:07 -0700 (PDT)
Received: from C02W82TBHV2R ([116.75.57.209])
        by smtp.gmail.com with ESMTPSA id p1sm17983709pfq.114.2020.04.08.20.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 20:32:06 -0700 (PDT)
Date:   Thu, 9 Apr 2020 09:02:01 +0530
From:   Srikrishan Malik <srikrishanmalik@gmail.com>
To:     Steve Dickson <SteveD@RedHat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: libnfsidmap: SASL bind suppoprt in umich_ldap
Message-ID: <20200409033201.GA8924@C02W82TBHV2R>
References: <20200330123501.GA50689@C02W82TBHV2R>
 <b9c6f7bd-ed86-4951-98cc-0e2938d0a2c3@RedHat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9c6f7bd-ed86-4951-98cc-0e2938d0a2c3@RedHat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Mar 30, 2020 at 11:06:54AM -0400, Steve Dickson wrote:
> Hello,
> 
> On 3/30/20 8:42 AM, Srikrishan Malik wrote:
> > Hi,
> > 
> > This is regarding the umich_ldap plugin in libnfsidmap.
> > This plugin uses only simple bind, are there any
> > plans/ongoing efforts to support SASL binds.
> No... Not that I'm aware of... Patches welcomed!  ;-) 

Sent a patch for this.

> 
> steved.
> 
